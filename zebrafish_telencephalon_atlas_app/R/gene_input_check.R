#' gene_input_check
#' Checks that feature/gene input is valid for active dataset. By default, input is converted to
#' zebrafish gene nomenclature (all lowercase), but users have the choice to overwrite default by
#' typing feature name inside double quotes to search for features which do not yet follow standard nomenclature. 
#' @param user_gene Gene/Feature name
#' @param dataset A Seurat object
#' @param assay Assay within the Seurat object to search gene/features. Default is  "RNA"
#'
#' @return Feature name
#' @export
#'
#' @examples
#' \dontrun{
#' gene_input_check(user_gene = 'snap25a', dataset = input_obj, assay = 'RNA')
#' }
#' \dontrun{
#' gene_input_check(user_gene = '"TMEM229A"', dataset = input_obj, assay = 'RNA') #does not convert to lowercase
#' }
gene_input_check <- function(user_gene, dataset, assay = "RNA") {
  # first ensure the correct assay is selected under each mode
  dataset <- change_assay(dataset = dataset, assay = assay)
  
  # ensure that the input is not empty
  validate(
    need(nchar(user_gene) > 0,
         message = "You did not type a gene name. Please choose a gene (e.g.: snap25a)")
  )
  
  # if user types gene name inside quotes, app will reads as is (no nomenclature conversion)
  
  # I use '"' but can also use "\"", with quote escaped ...
  if ((substr(user_gene,1,1) == '"' & substr(user_gene,nchar(user_gene),nchar(user_gene)) == '"')) {
    
    # if user used quotes, we then now need to remove it to search it within the object as is
    
    user_gene <- gsub("\"","",user_gene, fixed = TRUE)
    
    #NOTE: if other assays are added at any time point, can be flexible here with more assays
    if (DefaultAssay(dataset) == "RNA") {
      
      validate(
        need(user_gene %in% rownames(dataset@assays$RNA@data),
             message = paste0("The gene name ", user_gene, " was not found in the dataset"))
      )
      
      return(user_gene)
      
    }
    
  } else {
    
    # remove any empty spaces if present
    user_gene <- gsub(" ","",user_gene, fixed = TRUE)
    
    # convert any input gene to zebrafish nomeclature
    user_gene <- tolower(user_gene)
    
    if ("RNA" %in% Assays(dataset)) {
      
      validate(
        need(user_gene %in% rownames(dataset@assays$RNA@data),
             message = paste0("The gene name ", user_gene, " was not found in the dataset"))
      )
      
      return(user_gene)
      
    }
  }
}
