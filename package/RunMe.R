################## README ################## 
# This is an OHDSI study being
#coordinated by the Johns Hopkins Myositis Center. Please see our post on the
#OHDSI forum for links the protocol, repository, or for more information.
#
# Packages will be installed by this script. Please see the repository readme for
# details on setting up an isolated environment and for general information on study
# package execution.



################## env setup ##################
# All variables that need to be changed are in this section.

## Meta data for site
site_name <- 'Institution name'
site_contact <- 'John Doe'
site_contact_email <- 'john.doe@institution.edu'

## CDM connection details. The values used at JHU are included as a reference.
# Please see https://github.com/OHDSI/DatabaseConnector/raw/main/inst/doc/Connecting.pdf for details

dbms = 'sql server'
server = 'ESMPMDBPR4.WIN.AD.JHU.EDU'
pathToDriver = Sys.getenv('DATABASECONNECTOR_JAR_FOLDER')
extraSettings = 'integratedSecurity=true;encrypt=false;'

## Some environments require a connection sting to be given (ex JODBC on Linux'). Use of a connection string will override the above.
# connectionString = 'jdbc:sqlserver://esmpmdbpr4.esm.johnshopkins.edu:1433;database=Myositis_OMOP;integratedSecurity=true;authenticationScheme=JavaKerberos;encrypt=false'


## Set GITHUB Token if not already included in profile. Obtain with usethis::create_github_token() if needed.
#Sys.setenv(GITHUB_PAT = '')


## CDM Schema details. The values used at JHU are included as a reference.
cohortDatabaseSchema <- 'Myositis_OMOP.Temp'
cdmDatabaseSchema <- 'Myositis_OMOP.dbo'
workDatabaseSchema <- 'Myositis_OMOP.Temp'
cohortTable <- 'Dermatomyositis'


# Exclude results that due not meet the minimum cell count to protect participant privacy.
# If your site governance body requires a larger minimum, contact the study team before proceeding.
minCellCount <- 5

## JHU specific workarounds for Java installation. These are included as a reference
Sys.setenv(JAVA_HOME = 'C:/Program Files/Microsoft/jdk-17.0.8.101-hotspot')
options(java.parameters = '-Xmx10000m')



## A shortname to describe your cohort. Do not include spaces. The value used at JHU shown as a reference.
databaseId <- 'JHM_OMOP'


## Path to database connector drivors used for your RDMS.
#  Use DatabaseConnector::downloadJdbcDrivers(<driver>) to download drivers for your RDMS.
 
pathToDriver = '~/data_projects/database_drivers'
## Auth DLL needed for some MSSQL configurations












################# study vars ########################
# These should not be changed by the site


# cohorts
xSpecCohortId <- 1788683
xSensCohortId <- 1788688
prevalenceCohortId <- 1788504
phenotypeCohortIds <- c(1781804,1788567,1787425,1788503,1789031,1789032,1788875,1789289)


# dependancies
packages <- list(
  list(name = 'here', source = 'CRAN'),
  list(name = 'remotes', source = 'CRAN'),
  list(name = 'rJava', source = 'CRAN'),
  list(name = 'CohortDiagnostics', source = 'GitHub'),
  list(name = 'PheValuator', source = 'GitHub'),
  list(name = 'DatabaseConnector', source = 'CRAN'),
  list(name = 'CohortGenerator', source = 'GitHub'),
  list(name = 'cli', source = 'CRAN'),
  list(name = 'stringr', source = 'CRAN')
)


# output
outputFolder = 'results/phevaluator'
exportFolder = 'results/cohort_diagnostics'

# PheValuator phenotype name
phenotype <- 'Dermatomyositis'

################## study execution ##################
# Nothing should be changed in this section, var declarations are all above



# Install packages
for (pkg in packages) {
  if (!require(pkg$name, character.only = TRUE)) {
    if (pkg$source == 'CRAN') {
      install.packages(pkg$name)
    } else if (pkg$source == 'GitHub') {
      remotes::install_github(
        paste0('OHDSI/', pkg$name),
        force = TRUE,
        dependencies = TRUE,
        upgrade = 'never'
      )
    }
  }
  library(pkg$name, character.only = TRUE)
  print(paste0(pkg$name, ' installed'))
}


# Create (or recreate) results directory
if (dir.exists('results')) {
  print(paste('cleaning up old results directory:', getwd(), outputFolder))
  unlink('results', recursive = TRUE)
}
dir.create(outputFolder, recursive = TRUE)
dir.create(exportFolder, recursive = TRUE)


# Save metadata
library('uuid')
run_id <- UUIDgenerate()
meta_data <-
  list(
    'site_name' = site_name,
    'site_contact' = site_contact,
    'site_contact_email' = site_contact_email,
    'run_id' = run_id
  )
save(meta_data, file = paste0('results/', databaseId, '_', run_id, '.rda'))


# Setup CDM connection
if (exists('connectionString')) {
  connectionDetails <- createConnectionDetails(
    dbms = dbms,
    pathToDriver = pathToDriver,
    connectionString = connectionString
  )
} else {
  connectionDetails <- createConnectionDetails(
    dbms = dbms,
    server = server,
    pathToDriver = pathToDriver,
    extraSettings = extraSettings
  )
}

# Extract cohort definitions for xSpec, xSen, prevalence, and covariate exclusion

CohortDefinitionSet <- getCohortDefinitionSet(
        settingsFileName = "inst/cohorts.csv",
        jsonFolder = "inst/cohorts",
        sqlFolder = "inst/sql/sql_server",
        cohortFileNameFormat = "%s",
        cohortFileNameValue = c("cohortId"),
        packageName = NULL,
        warnOnMissingJson = TRUE,
        verbose = FALSE
)

evaluatedCohorts  <- CohortDefinitionSet[CohortDefinitionSet$cohortId %in% phenotypeCohortIds, ]    
phevaluatorCohorts  <- CohortDefinitionSet[CohortDefinitionSet$cohortId %in% c(xSpecCohortId, xSensCohortId, prevalenceCohortId), ]    



xSpecDefinitionSql <- phevaluatorCohorts$sql[CohortDefinitionSet$cohortId == xSpecCohortId]
xSpecConceptsExtracted <-
  str_extract_all(
    xSpecDefinitionSql,
    '(?<=select concept_id from @vocabulary_database_schema.CONCEPT where concept_id in \\()[0-9,]+(?=\\))'
  )
xSpecConceptsAll <-
  paste(xSpecConceptsExtracted[[1]], collapse = ',')

# Covariate Settings
covariateSettings <-
  createDefaultCovariateSettings(
    excludedCovariateConceptIds = xSpecConceptsAll,
    includedCovariateIds = c(),
    includedCovariateConceptIds = c(),
    addDescendantsToExclude = FALSE,
    startDayWindow1 = 0,
    endDayWindow1 = 9999,
    startDayWindow2 = NULL,
    endDayWindow2 = NULL,
    startDayWindow3 = NULL,
    endDayWindow3 = NULL
  )

# Evaluation Cohort Arguments
CohortArgs <-
  createCreateEvaluationCohortArgs(
    xSpecCohortId = xSpecCohortId,
    xSensCohortId = xSensCohortId,
    prevalenceCohortId = prevalenceCohortId,
    covariateSettings = covariateSettings
  )

# Create analysis package for all cohorts to be evaluated
pheValuatorAnalysisList <- list()
for (i in seq_along(phenotypeCohortIds)) {
  cutPoints = 'EV'
  cohortId = phenotypeCohortIds[i]
  cohortDefinition <- evaluatedCohorts[cohortId == cohortId]
  
  
  washoutPeriod <-
    (cohortDefinition$expression$PrimaryCriteria$ObservationWindow[1][['PriorDays']])
  AlgTestArgs <-
    createTestPhenotypeAlgorithmArgs(
      cutPoints = cutPoints,
      phenotypeCohortId = cohortId,
      washoutPeriod = washoutPeriod
    )
  analysis <- createPheValuatorAnalysis(
    analysisId = i,
    description = cohortDefinition$name,
    createEvaluationCohortArgs = CohortArgs,
    testPhenotypeAlgorithmArgs = AlgTestArgs
  )
  cat(
    paste0(
      '\n========================================\n',
      'analysisId = ',
      i,
      '\ncutPoints = ',
      cutPoints,
      '\nphenotypeCohortId = ',
      cohortId,
      '',
      '\nwashoutPeriod = ',
      washoutPeriod,
      '\ndescription = ',
      cohortDefinition$name
    )
  )
  pheValuatorAnalysisList[[length(pheValuatorAnalysisList) + 1]] <-
    analysis
}


connection <- connect(connectionDetails)

# Create cohort table on database, should print counts if successful
cohortTableNames <- getCohortTableNames(
  cohortTable = cohortTable,
  cohortInclusionTable = paste0(cohortTable, '_inclusion'),
  cohortInclusionResultTable = paste0(cohortTable, '_inclusion_result'),
  cohortInclusionStatsTable = paste0(cohortTable, '_inclusion_stats'),
  cohortSummaryStatsTable = paste0(cohortTable, '_summary_stats'),
  cohortCensorStatsTable = paste0(cohortTable, '_censor_stats')
)

createCohortTables(
  connection = connection,
  cohortTableNames = cohortTableNames,
  cohortDatabaseSchema = cohortDatabaseSchema
)

cohortDefinitionSet <- rbind(phevaluatorCohorts, evaluatedCohorts)

cohortsGenerated <- generateCohortSet(
  connection = connection,
  cdmDatabaseSchema = cdmDatabaseSchema,
  cohortDatabaseSchema = cohortDatabaseSchema,
  cohortTableNames = cohortTableNames,
  cohortDefinitionSet = cohortDefinitionSet
)

cohortCounts <- getCohortCounts(
  connection = connection,
  cohortDatabaseSchema = cohortDatabaseSchema,
  cohortTable = cohortTableNames$cohortTable
)
print(cohortCounts)

# Execute Cohort Diagnosis
executeDiagnostics(
  cohortDefinitionSet = evaluatedCohorts,
  connectionDetails = connectionDetails,
  cohortTable = cohortTableNames$cohortTable,
  cohortDatabaseSchema = cohortDatabaseSchema,
  cdmDatabaseSchema = cdmDatabaseSchema,
  exportFolder = exportFolder,
  databaseId = databaseId,
  minCellCount = minCellCount
)

# Execute Phevaluator
referenceTable <- runPheValuatorAnalyses(
  phenotype = phenotype,
  connectionDetails = connectionDetails,
  cdmDatabaseSchema = cdmDatabaseSchema,
  cohortDatabaseSchema = cohortDatabaseSchema,
  cohortTable = cohortTableNames$cohortTable,
  workDatabaseSchema = workDatabaseSchema,
  outputFolder = outputFolder,
  pheValuatorAnalysisList = pheValuatorAnalysisList
)


# Drop tables that are not needed anymore
CohortGenerator::dropCohortStatsTables(
  connectionDetails = connectionDetails,
  cohortDatabaseSchema = cohortDatabaseSchema,
  cohortTableNames = cohortTableNames
)

# Delete plp model state file (large, not human readable, and not needed for the analysis)
file.remove(
  list.files(
    path = 'results',
    pattern = '^covariates$',
    full.names = TRUE,
    recursive = TRUE
  )
)


# Upload results
results_file <-
  paste('results_',
        databaseId,
        '_',
        run_id,
        '.zip',
        col = '',
        sep = '')
files <- dir('results', full.names = TRUE)
zip(zipfile = results_file, files = files)

readline(
  prompt = 'Completed! The contents of /results have been compressed as results.zip.
         Please inspect these files to ensure that the contents do not contain
         any patient data and submit results.zip to the study team using the OneDrive link provided to you.
         If you need a onedrive link, please contact the study team. Prease [enter] to confirm.'
)
