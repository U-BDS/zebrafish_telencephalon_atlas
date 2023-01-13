#' DotPlot_ordered
#' A wrapper function of DotPlot to order dataset according to 
#' published app data and set other DotPlot defaults by app.
#'
#' @param dataset A Seurat object
#' @param features Gene/Feature name
#' @param colors Colors to plot
#' @param idents Identity classes to include in plot (default is all)
#' @param split_type Factor to split the groups by. Default is show all / do not split.
#' @param assay Assay within the Seurat object to be made default. Default is  "RNA"
#'
#' @return A ggplot object
#' @export
#'
DotPlot_ordered <- function(dataset, features, colors, idents, split_type = "All", assay = "RNA") {
  
  #NOTE: if needed, can make Ident. order rev (or other order needs) a user option
  Idents(dataset) <- factor(x = Idents(dataset), levels = rev(levels(dataset)))
  
  DotPlot(object = dataset, 
          features = features, 
          cols = colors,
          idents = idents,
          split.by  = split_type,
          assay = assay,
          dot.scale = 10) + RotatedAxis()
}
