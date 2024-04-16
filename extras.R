rootFolder <- "D:\\git\\github\\ohdsi-studies\\MyositisNetworkStudy"

baseUrl <- "https://api.ohdsi.org/WebAPI"

publicAtlasCohortIds <- c(1789289, 1789290)

cohortDefinitionSet <- ROhdsiWebApi::exportCohortDefinitionSet(baseUrl = baseUrl, cohortIds = publicAtlasCohortIds, generateStats = TRUE) |> 
  dplyr::select(cohortId,
                cohortName,
                sql,
                json)


# modify if needed e.g. maybe change the cohortId

cohortDefinitionSet <- cohortDefinitionSet |> 
  dplyr::arrange(cohortId) |> 
  dplyr::mutate(cohortId = dplyr::row_number())

# you can change cohortName is public atlas - if you want clean names
#


dir.create("d://git//myositis//") # where you clone the repository
setwd("d://git//myositis//")

CohortGenerator::saveCohortDefinitionSet(cohortDefinitionSet = cohortDefinitionSet)

