################## README ################## 
# This script is for use by the study team to fetch cohorts using WebAPI and
# save them to the study package. This script should not be used during study
# execution and is included for reference only.

library(CohortGenerator)
library(ROhdsiWebApi)

################## Configuration ##################

# Base URL for WebAPI
baseUrl <- 'http://api.ohdsi.org:8080/WebAPI'

# Cohort IDs
CohortIds <- c(
  1781804, 1788567, 1787425, 1788503, 1789031, 1789032,
  1788875, 1789289, 1788683, 1788688, 1788504
)

################## Functions ##################

fetch_cohort_definitions <- function(baseUrl, cohortIds) {
  exportCohortDefinitionSet(
    baseUrl = baseUrl,
    cohortIds = cohortIds,
    generateStats = TRUE
  )
}

save_cohort_definitions <- function(cohortDefinitionSet) {
  saveCohortDefinitionSet(
    cohortDefinitionSet,
    settingsFileName = "inst/cohorts.csv",
    jsonFolder = "inst/cohorts",
    sqlFolder = "inst/sql/sql_server",
    cohortFileNameFormat = "%s",
    cohortFileNameValue = c("cohortId"),
    subsetJsonFolder = "inst/cohort_subset_definitions/",
    verbose = TRUE
  )
}

################## Main Execution ##################

# Fetch cohort definitions
cohortDefinitions <- fetch_cohort_definitions(baseUrl, CohortIds)

# Save cohort definitions
save_cohort_definitions(cohortDefinitions)