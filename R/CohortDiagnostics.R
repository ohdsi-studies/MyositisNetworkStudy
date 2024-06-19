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
execute_diagnostics_study <- function(evaluatedCohorts,
                                connectionDetails,
                                connection,
                                cohortDatabaseSchema,
                                cdmDatabaseSchema,
                                exportFolder,
                                databaseId,
                                minCellCount,
                                cohortTable,
                                cohortDefinitionSet) {
  

ParallelLogger::logInfo("Creating cohorts.")
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
  
  cohortsGenerated <- generateCohortSet(
    connection = connection,
    cdmDatabaseSchema = cdmDatabaseSchema,
    cohortDatabaseSchema = cohortDatabaseSchema,
    cohortTableNames = cohortTableNames,
    cohortDefinitionSet = cohortDefinitionSet
  )

  ParallelLogger::logInfo("Validating that generated cohorts meet requirments for study participation.")

  cohortCounts <- getCohortCounts(
    connection = connection,
    cohortDatabaseSchema = cohortDatabaseSchema,
    cohortTable = cohortTableNames$cohortTable
  )
  validate_site(cohortCounts, xSpecCohortId)
  
  
  
  ParallelLogger::logInfo("Executing cohortDiagnostics.")
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
  
  return (cohortTableNames)
}


