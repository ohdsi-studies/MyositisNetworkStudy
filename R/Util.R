############## Helper code #######################

#' setup_directories
#'
#' @param outputFolder 
#' @param exportFolder 
#'
#' @return
#' @export
#'
#' @examples
setup_directories <- function(outputFolder, exportFolder) {
  if (dir.exists('results')) {
    print(paste('Cleaning up old results directory:', getwd(), outputFolder))
    unlink('results', recursive = TRUE)
  }
  dir.create(outputFolder, recursive = TRUE)
  dir.create(exportFolder, recursive = TRUE)
}

#' save_metadata
#'
#' @param site_name 
#' @param site_contact 
#' @param site_contact_email 
#' @param databaseId 
#'
#' @return
#' @import uuid
#'
#' @examples
save_metadata <- function(site_name, site_contact, site_contact_email, databaseId) {
  run_id <- UUIDgenerate()
  meta_data <- list(
    'site_name' = site_name,
    'site_contact' = site_contact,
    'site_contact_email' = site_contact_email,
    'run_id' = run_id
  )
  save(meta_data, file = paste0('results/', databaseId, '_', run_id, '.rda'))
  return(run_id)
}



#' validate_site
#'
#' @param cohortCounts 
#' @param xSpecCohortId 
#'
#' @return
#' @export
#'
#' @examples
validate_site <- function(cohortCounts, xSpecCohortId) {
  xSpecCohortSize <- cohortCounts$cohortSubjects[cohortCounts$cohortId == xSpecCohortId]
  if (xSpecCohortSize >= 250) {
    print(paste0('Site validation passed. xSpecCohortSize: ', xSpecCohortSize))
  } else {
    print(paste0('Site validation FAILED: xSpec cohort does not meet minimum size for participation. xSpecCohortSize: ', xSpecCohortSize))
  }
}


#' clean_up
#'
#' @param connectionDetails 
#' @param cohortDatabaseSchema 
#' @param cohortTableNames 
#'
#' @return
#'
#' @examples
clean_up_tables <- function(connectionDetails, cohortDatabaseSchema, cohortTableNames) {
  CohortGenerator::dropCohortStatsTables(
    connectionDetails = connectionDetails,
    cohortDatabaseSchema = cohortDatabaseSchema,
    cohortTableNames = cohortTableNames
  )
  
  # Remove plp models to save space
  dirs_to_unlink <- list.dirs(path = 'results', recursive = TRUE)
  dirs_to_unlink <- dirs_to_unlink[grep('plpData_main', dirs_to_unlink)]
  unlink(dirs_to_unlink, recursive = TRUE)
  
  # Delete unneeded files from output and files that could potentially contain patient level data.
  unlink(list.files(path = 'results', pattern = '^pv_test_subjects.csv$', full.names = TRUE, recursive = TRUE))
  unlink(list.files(path = 'results', pattern = '^pv_test_subjects_covariates.csv$', full.names = TRUE, recursive = TRUE))
}


#' save_results
#'
#' @param databaseId 
#' @param run_id 
#'
#' @return
#' @export
#'
#' @examples
save_results <- function(databaseId, run_id) {
  results_file <- paste0('results_', databaseId, '_', run_id, '.zip')
  files <- dir('results', full.names = TRUE)
  zip(zipfile = results_file, files = files)
  
}
