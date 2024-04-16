rootFolder <- "D:\\git\\github\\ohdsi-studies\\MyositisNetworkStudy"

baseUrl <- "https://api.ohdsi.org/WebAPI"

publicAtlasCohortIds <-
  c(
    1781804,
    1788567,
    1787425,
    1788503,
    1789031,
    1789032,
    1788875,
    1789289,
    1788683,
    1788688,
    1788504
  )

cohortDefinitionSet <-
  ROhdsiWebApi::exportCohortDefinitionSet(baseUrl = baseUrl,
                                          cohortIds = publicAtlasCohortIds,
                                          generateStats = TRUE) |>
  dplyr::select(cohortId,
                cohortName,
                sql,
                json) |>
  dplyr::arrange(cohortId) |>
  dplyr::rename(publicAtlasCohortId = cohortId) |>
  dplyr::mutate(cohortId = dplyr::row_number())

# save as RDS object
saveRDS(object = cohortDefinitionSet, file = "CohortDefinitionSet/CohortDefinitionSetFromPublicAtlas.RDS")
cohortDefinitionSet <- readRDS("CohortDefinitionSet/CohortDefinitionSetFromPublicAtlas.RDS")


# save the full specification as csv files
CohortGenerator::saveCohortDefinitionSet(
  cohortDefinitionSet = cohortDefinitionSet |> 
    dplyr::select(cohortId,
                  cohortName,
                  json,
                  sql),
  settingsFileName = "CohortDefinitionSet/inst/Cohorts.csv",
  jsonFolder = "CohortDefinitionSet/inst/cohorts",
  sqlFolder = "CohortDefinitionSet/inst/sql/sql_server"
)

# generate cohort sql using latest version of circeR
circeOptions <- CirceR::createGenerateOptions(generateStats = TRUE)

cohortJsonFiles <-
  list.files(path = file.path("CohortDefinitionSet", "inst", "cohorts"), pattern = ".json", full.names = TRUE) |> sort()


for (i in (1:length(cohortJsonFiles))) {
  jsonFileName <- cohortJsonFiles[i]
  sqlFileName <-
    stringr::str_replace_all(
      string = basename(jsonFileName),
      pattern = stringr::fixed(".json"),
      replacement = ".sql"
    )
  
  writeLines(paste0(" - Generating ", sqlFileName))
  
  json <-
    SqlRender::readSql(sourceFile = jsonFileName)
  sql <-
    CirceR::buildCohortQuery(expression = json, options = circeOptions)
  writeLines(paste0(" --", sqlFileName))
  unlink(
    x = file.path("CohortDefinitionSet", "inst", "sql", "sql_server", sqlFileName),
    recursive = TRUE,
    force = TRUE
  )
  SqlRender::writeSql(
    sql = sql,
    targetFile = file.path("CohortDefinitionSet", "inst", "sql", "sql_server", sqlFileName)
  )
}


cohortDefinitionSet <- CohortGenerator::getCohortDefinitionSet(
  settingsFileName = "CohortDefinitionSet/inst/Cohorts.csv",
  jsonFolder = "CohortDefinitionSet/inst/cohorts",
  sqlFolder = "CohortDefinitionSet/inst/sql/sql_server"
)
saveRDS(object = cohortDefinitionSet, file = "CohortDefinitionSet/CohortDefinitionSet.RDS")
cohortDefinitionSet <- readRDS("CohortDefinitionSet/CohortDefinitionSet.RDS")


# create cohort diagnostics study package
outputFolder <- "CohortDiagnostics"  # location where you study package will be created


########## Please populate the information below #####################
version <- "v0.1.0"
name <- "Myositis - cohort diagnostics"
packageName <- "myositisCohortDiagnostics"
skeletonVersion <- "v0.0.1"
createdBy <- "bmarti86@jh.edu"
createdDate <- Sys.Date() # default
modifiedBy <- "bmarti86@jh.edu"
modifiedDate <- Sys.Date()
skeletonType <- "CohortDiagnosticsStudy"
organizationName <- "OHDSI"
description <- "Cohort diagnostics on Myositis."

# compile them into a data table
cohortDefinitionsArray <- list()
for (i in (1:nrow(cohortDefinitionSet))) {
  cohortDefinition <-
    cohortDefinitionSet[i,]$json |> RJSONIO::fromJSON(digits = 23)
  cohortDefinitionsArray[[i]] <- list(
    id = cohortDefinitionSet[i,]$cohortId,
    name = cohortDefinitionSet[i,]$cohortName,
    expression = cohortDefinition
  )
}

tempFolder <- tempdir()
unlink(x = tempFolder,
       recursive = TRUE,
       force = TRUE)
dir.create(path = tempFolder,
           showWarnings = FALSE,
           recursive = TRUE)

specifications <- list(
  id = 1,
  version = version,
  name = name,
  packageName = packageName,
  skeletonVersion = skeletonVersion,
  createdBy = createdBy,
  createdDate = createdDate,
  modifiedBy = modifiedBy,
  modifiedDate = modifiedDate,
  skeletonType = skeletonType,
  organizationName = organizationName,
  description = description,
  cohortDefinitions = cohortDefinitionsArray
)

jsonFileName <-
  paste0(file.path(tempFolder, "CohortDiagnosticsSpecs.json"))
write(x = specifications |> RJSONIO::toJSON(pretty = TRUE, digits = 23),
      file = jsonFileName)


download.file(url = "https://github.com/OHDSI/SkeletonCohortDiagnosticsStudy/archive/refs/heads/main.zip",
              destfile = file.path(tempFolder, 'skeleton.zip'))
unzip(
  zipfile =  file.path(tempFolder, 'skeleton.zip'),
  overwrite = TRUE,
  exdir = file.path(tempFolder, "skeleton")
)
fileList <-
  list.files(
    path = file.path(tempFolder, "skeleton"),
    full.names = TRUE,
    recursive = TRUE,
    all.files = TRUE
  )
DatabaseConnector::createZipFile(
  zipFile = file.path(tempFolder, 'skeleton.zip'),
  files = fileList,
  rootFolder = list.dirs(file.path(tempFolder, 'skeleton'), recursive = FALSE)
)

hydraSpecificationFromFile <-
  Hydra::loadSpecifications(fileName = jsonFileName)
unlink(x = outputFolder, recursive = TRUE)
dir.create(path = outputFolder,
           showWarnings = FALSE,
           recursive = TRUE)

Hydra::hydrate(
  specifications = hydraSpecificationFromFile,
  outputFolder = outputFolder,
  skeletonFileName = file.path(tempFolder, 'skeleton.zip')
)
unlink(x = tempFolder,
       recursive = TRUE,
       force = TRUE)
