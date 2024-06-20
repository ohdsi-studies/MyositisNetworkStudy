############## CohortDiagnostics code #######################


#' execute_diagnostics_study 
#'
#' @param evaluatedCohorts 
#' @param connectionDetails 
#' @param connection 
#' @param cohortDatabaseSchema 
#' @param cdmDatabaseSchema 
#' @param exportFolder 
#' @param databaseId 
#' @param minCellCount 
#' @param cohortTable 
#' 
#' @import CohortDiagnostics
#' @import ParallelLogger 
#' @import DatabaseConnector 
#' @return
#'
execute_diagnostics_study <- function(connectionDetails,
                                connection,
                                cohortDatabaseSchema,
                                cdmDatabaseSchema,
                                exportFolder,
                                databaseId,
                                minCellCount,
                                cohortTable,
                                cohortDefinitionSet) {
  

print("Creating cohorts.")
cohortTableNames <- CohortGenerator::getCohortTableNames(
    cohortTable = cohortTable,
    cohortInclusionTable = paste0(cohortTable, '_inclusion'),
    cohortInclusionResultTable = paste0(cohortTable, '_inclusion_result'),
    cohortInclusionStatsTable = paste0(cohortTable, '_inclusion_stats'),
    cohortSummaryStatsTable = paste0(cohortTable, '_summary_stats'),
    cohortCensorStatsTable = paste0(cohortTable, '_censor_stats')
  )

CohortGenerator::createCohortTables(
    connection = connection,
    cohortTableNames = cohortTableNames,
    cohortDatabaseSchema = cohortDatabaseSchema
  )
  
  cohortsGenerated <- CohortGenerator::generateCohortSet(
    connection = connection,
    cdmDatabaseSchema = cdmDatabaseSchema,
    cohortDatabaseSchema = cohortDatabaseSchema,
    cohortTableNames = cohortTableNames,
    cohortDefinitionSet = cohortDefinitionSet
  )

  print("Validating that generated cohorts meet requirments for study participation.")

  cohortCounts <- CohortGenerator::getCohortCounts(
    connection = connection,
    cohortDatabaseSchema = cohortDatabaseSchema,
    cohortTable = cohortTableNames$cohortTable
  )
  validate_site(cohortCounts, xSpecCohortId)
  
  
  
  print("Executing cohortDiagnostics.")
  CohortDiagnostics::executeDiagnostics(
    cohortDefinitionSet = cohortDefinitionSet,
    connectionDetails = connectionDetails,
    cohortTable = cohortTableNames$cohortTable,
    cohortDatabaseSchema = cohortDatabaseSchema,
    cdmDatabaseSchema = cdmDatabaseSchema,
    exportFolder = exportFolder,
    databaseId = databaseId,
    minCellCount = minCellCount
  )
  
  return (cohortTableNames)
}


