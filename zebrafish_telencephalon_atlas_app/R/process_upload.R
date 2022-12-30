#' process_upload
#' Pre-process csv uploads to validate genes/features added in the file. The file should not contain a header.
#' @param input_path the path to the query csv file expected by the app
#' @param header a logical value indicating whether the file contains the names of the variable as first line.
#' @param ... params to be passed on to `gene_input_check`
#'
#' @return A character vector expected for further processing within the app
#' @export
#'
#' @examples
#' \dontrun{
#' process_upload("./data/query.csv")
#' }
process_upload <- function(input_path, header = TRUE, ...) {
  
  # process upload to add it to expected format (wider and comma-separated per allele)
  user_query_upload <- read.csv(input_path, header = header, colClasses = "character")
  
  # check that expected columns are present (single-col. file)
  
  validate(
    need(ncol(user_query_upload) == 1,
         message = paste0(
           "Unexpected number of columns found! Ensure only a single ",
           "column is present with the name of the genes/features"
         )
    )
  )
  
  # run unique to ensure genes/features are present only once
  # (would indicate duplicates in sample names and/or markers per sample)
  
  user_query_upload <- unique(user_query_upload)
  
  # setting a max number of genes for DotPlot to a sensible default.
  # for users with very small screens, they still have the option 
  # of saving the plot on larger size
  validate(
    need(nrow(user_query_upload) <= 60,
         message = paste0(
           "Input number of genes/features is greater than 60! The maximun number of features ",
           "has been set to 60 as a sensible default for DotPlots. Please reduce your input to ",
           "60 genes/features at a time."
         )
    )
  )
  
  # validate entries (convert to lowercase when needed or ignore if inside "")
  
  user_query_upload <- as.character(apply(user_query_upload, MARGIN = 1, FUN = gene_input_check, ...))
  
  return(user_query_upload)
}
