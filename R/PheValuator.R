################# PheValuator code #######################




#' extract_concepts
#'
#' @param phevaluatorCohorts 
#' @param xSpecCohortId 
#'
#' @return
#' @import stringr
#'
#' @examples
#' create_phevaluator_analysis_list
#'
#' @param phenotypeCohortIds 
#' @param evaluatedCohorts 
#' @param CohortArgs 
#'
#' @return
#'
#' @examples
create_phevaluator_analysis_list <- function(phenotypeCohortIds, evaluatedCohorts, CohortArgs) {
  pheValuatorAnalysisList <- list()
  cohortDefinitions <- list()
  for (i in seq_along(phenotypeCohortIds)) {
    cutPoints <- 'EV'
    cohortId <- phenotypeCohortIds[i]
    cohortDefinition <- evaluatedCohorts[evaluatedCohorts$cohortId == cohortId,]
    washoutPeriod <- fromJSON(cohortDefinition$json)$PrimaryCriteria$ObservationWindow$PriorDays
    
    AlgTestArgs <- createTestPhenotypeAlgorithmArgs(
      cutPoints = cutPoints,
      phenotypeCohortId = cohortId,
      washoutPeriod = washoutPeriod
    )
    analysis <- createPheValuatorAnalysis(
      analysisId = i,
      description = cohortDefinition$cohortName,
      createEvaluationCohortArgs = CohortArgs,
      testPhenotypeAlgorithmArgs = AlgTestArgs
    )
    cat(paste0('\n========================================\n',
               'analysisId = ', i,
               '\ncutPoints = ', cutPoints,
               '\nphenotypeCohortId = ', cohortId,
               '\nwashoutPeriod = ', washoutPeriod,
               '\ndescription = ', cohortDefinition$cohortName
    ))
    pheValuatorAnalysisList[[length(pheValuatorAnalysisList) + 1]] <- analysis
  }
  return(pheValuatorAnalysisList)
}


#' execute_phevaluator_study 
#'
#' @param phenotype 
#' @param connectionDetails 
#' @param cdmDatabaseSchema 
#' @param cohortDatabaseSchema 
#' @param cohortTableNames 
#' @param workDatabaseSchema 
#' @param outputFolder 
#' @param xSpecCohortId 
#' @param xSensCohortId 
#' @param prevalenceCohortId 
#' @param phenotypeCohortIds 
#' @param CohortDefinitionSet 
#' @import ParallelLogger
#' @import PheValuator
#' @return
#'
#' @examples
execute_phevaluator_study  <- function(phenotype,
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
                                CohortDefinitionSet) {
  
  print("Configuring PheValuator.")
  # Extract concepts

  evaluatedCohorts <- CohortDefinitionSet[CohortDefinitionSet$cohortId %in% phenotypeCohortIds, ]    
  phevaluatorCohorts <- CohortDefinitionSet[CohortDefinitionSet$cohortId %in% c(xSpecCohortId, xSensCohortId, prevalenceCohortId), ]    
  xSpecConceptsAll <- c(257628,76685,373182,4215003,79804,78149,4216406)
  
  # Create covariate settings
  covariateSettings <- createDefaultCovariateSettings(
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

  # Create evaluation cohort arguments
  CohortArgs <- createCreateEvaluationCohortArgs(
    xSpecCohortId = xSpecCohortId,
    xSensCohortId = xSensCohortId,
    prevalenceCohortId = prevalenceCohortId,
    covariateSettings = covariateSettings
  )
    
  # Create Phevaluator analysis
  pheValuatorAnalysisList <- create_phevaluator_analysis_list(phenotypeCohortIds, CohortDefinitionSet, CohortArgs)
  
  
  print("Executing PheValuator.")
  referenceTable <- PheValuator::runPheValuatorAnalyses(
              phenotype = phenotype,
              connectionDetails = connectionDetails,
              cdmDatabaseSchema = cdmDatabaseSchema,
              cohortDatabaseSchema = cohortDatabaseSchema,
              cohortTable = cohortTableNames$cohortTable,
              workDatabaseSchema = workDatabaseSchema,
              outputFolder = outputFolder,
              pheValuatorAnalysisList = pheValuatorAnalysisList
        )
  return(referenceTable)
}
