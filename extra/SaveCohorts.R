################## README ################## 
# This script is foe use by the study team to fetch cohorts using WebAPI and
# save them to the study package. This script should not be used during study
# execution and is included for reference only.

library(CohortGenerator)
library(ROhdsiWebApi)

# cohorts
CohortIds <-
  c(1781804,
    1788567,
    1787425,
    1788503,
    1789031,
    1789032,
    1788875,
    1789289,
    1788683,
    1788688,
    1788504)

baseUrl <- 'http://api.ohdsi.org:8080/WebAPI'


# Extract cohort definitions for xSpec, xSen, prevalence, and covariate exclusion

cohorts <- exportCohortDefinitionSet(baseUrl = baseUrl,
                                              cohortIds = CohortIds,
                                              generateStats = TRUE,
                                               )



saveCohortDefinitionSet(
  cohortDefinitionSet,
  settingsFileName = "inst/cohorts.csv",
  jsonFolder = "inst/cohorts",
  sqlFolder = "inst/sql/sql_server",
  cohortFileNameFormat = "%s",
  cohortFileNameValue = c("cohortId"),
  subsetJsonFolder = "inst/cohort_subset_definitions/",
  verbose = FALSE
)
