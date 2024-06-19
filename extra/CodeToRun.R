################## README ################## 
# This is an OHDSI study being coordinated by the Johns Hopkins Myositis Center.
# Please see our post on the OHDSI forum for links to the protocol, repository, or for more information.
#
# Packages will be installed by this script. Please see the repository readme for
# details on setting up an isolated environment and for general information on study package execution.


################## Environment Setup ##################
# All variables that need to be changed are in this section.
library(MyositisNetworkStudy)


# Meta data for site
site_name <- 'Institution name'
site_contact <- 'John Doe'
site_contact_email <- 'john.doe@institution.edu'

# CDM connection details. The values used at JHU are included as a reference.
# Please see https://github.com/OHDSI/DatabaseConnector/raw/main/inst/doc/Connecting.pdf for details
connectionDetails <- createConnectionDetails(
    dbms = 'sql server',
    server = 'ESMPMDBPR4.WIN.AD.JHU.EDU',
    pathToDriver = '~/data_projects/database_drivers',
    extraSettings = 'integratedSecurity=true;encrypt=false;',
  # user = '',
  # password = '',
  # port = '',
# Some environments require a connection string to be given (ex JODBC on Linux).
# Use of a connection string will override the above.
  # connectionString <- 'jdbc:sqlserver://esmpmdbpr4.esm.johnshopkins.edu:1433;database=Myositis_OMOP;integratedSecurity=true;authenticationScheme=JavaKerberos;encrypt=false'
)

# Auth DLL needed for some MSSQL configurations
#Sys.setenv(PATH_TO_AUTH_DLL = '')

# Set GITHUB Token if not already included in profile. Obtain with usethis::create_github_token() if needed.
# Sys.setenv(GITHUB_PAT = '')

# CDM Schema details. The values used at JHU are included as a reference.
cohortDatabaseSchema <- 'Myositis_OMOP.Temp'
cdmDatabaseSchema <- 'Myositis_OMOP.dbo'
workDatabaseSchema <- 'Myositis_OMOP.Temp'
cohortTable <- 'Dermatomyositis'

# Exclude results that do not meet the minimum cell count to protect participant privacy.
# If your site governance body requires a larger minimum, contact the study team before proceeding.
minCellCount <- 5

# JHU specific workarounds for Java installation. These are included as a reference
Sys.setenv(JAVA_HOME = 'C:/Program Files/Microsoft/jdk-17.0.8.101-hotspot')
options(java.parameters = '-Xmx10000m')

# A short name to describe your cohort. Do not include spaces. The value used at JHU is shown as a reference.
databaseId <- 'JHM_OMOP'


################# Study Variables ########################
# These should not be changed by the site
verifyDependencies = FALSE


# Cohorts
xSpecCohortId <- 1788683
xSensCohortId <- 1788688
prevalenceCohortId <- 1788504
phenotypeCohortIds <- c(1781804, 1788567, 1787425, 1788503, 1789031, 1789032, 1788875, 1789289)


# Output
outputFolder <- 'results/phevaluator'
exportFolder <- 'results/cohort_diagnostics'

# PheValuator phenotype name
phenotype <- 'Dermatomyositis'



################## Main Execution ##################


## Save execution log
ParallelLogger::addDefaultFileLogger('results/execution_log.txt')
ParallelLogger::addDefaultErrorReportLogger('results/eerrorReportR.txt')
on.exit(ParallelLogger::unregisterLogger("DEFAULT_FILE_LOGGER", silent = TRUE))
on.exit(
  ParallelLogger::unregisterLogger("DEFAULT_ERRORREPORT_LOGGER", silent = TRUE),
  add = TRUE
)

# Install packages
install_packages(packages)


if (verifyDependencies) {
  ParallelLogger::logInfo("Checking whether correct package versions are installed")
  verifyDependencies()
}

# Setup directories
ParallelLogger::logInfo("(Re)creating results directory.")
setup_directories(outputFolder, exportFolder)

# Save metadata
ParallelLogger::logInfo("Exporting metadata.")
run_id <- save_metadata(site_name, site_contact, site_contact_email, databaseId)


# Extract cohort definitions for xSpec, xSen, prevalence, and covariate exclusion
ParallelLogger::logInfo("Loading cohort definitions from study package.")
CohortDefinitionSet <- getCohortDefinitionSet(
  settingsFileName = 'inst/cohorts.csv',
  jsonFolder = 'inst/cohorts',
  sqlFolder = 'inst/sql/sql_server',
  cohortFileNameFormat = '%s',
  cohortFileNameValue = c('cohortId'),
  packageName = NULL,
  warnOnMissingJson = TRUE,
  verbose = FALSE
)


# Setup CDM connection
ParallelLogger::logInfo("Setting up database connection.")
connection <- connect(connectionDetails)

# Execute diagnostics
ParallelLogger::logInfo("Execute CohortDiagnostics.")
cohortTableNames <- execute_diagnostics_study (evaluatedCohorts,
                                               connectionDetails,
                                               connection,
                                               cohortDatabaseSchema,
                                               cdmDatabaseSchema,
                                               exportFolder,
                                               databaseId,
                                               minCellCount,
                                               cohortTable,
                                               cohortDefinitionSet)



# Execute Phevaluator
referenceTable <- execute_phevaluator_study(phenotype, 
                                      connectionDetails,
                                      cdmDatabaseSchema,
                                      cohortDatabaseSchema,
                                      cohortTableNames,
                                      workDatabaseSchema,
                                      outputFolder,
                                      xSpecCohortId,
                                      xSensCohortId,
                                      prevalenceCohortId,
                                      phenotypeCohortIds,
                                      CohortDefinitionSet)

# Clean up
#clean_up_tables(connectionDetails, cohortDatabaseSchema, cohortTableNames)

# Save results
save_results(databaseId, run_id)

readline(prompt = 'Completed! The contents of /results have been compressed as results.zip.
           Please inspect these files to ensure that the contents do not contain
           any patient data and submit results.zip to the study team using the OneDrive link provided to you.
           If you need a OneDrive link, please contact the study team. Press [enter] to confirm.')

