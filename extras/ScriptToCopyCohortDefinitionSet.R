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

saveRDS(object = cohortDefinitionSet, file = "CohortDefinitionSet/CohortDefinitionSet.RDS")
cohortDefinitionSet <- readRDS("CohortDefinitionSet/CohortDefinitionSet.RDS")

CohortGenerator::saveCohortDefinitionSet(
  cohortDefinitionSet = cohortDefinitionSet,
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
