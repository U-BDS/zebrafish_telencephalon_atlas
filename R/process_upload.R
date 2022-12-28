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
  
  # validate entries (convert to lowercase when needed or ignore if inside "")
  
  user_query_upload <- as.character(apply(user_query_upload, MARGIN = 1, FUN = gene_input_check, ...))
  
  #TODO: add max number to a reasonable amount to be visualized within a dotplot
  
  return(user_query_upload)
}
