DotPlot_ordered <- function(dataset, features = features, idents = idents, assay = assay, colors = colors, split_type = "All") {
  
  # set order or DotPlot based on factor level of input object
  # (more of a factor for age-specific datasets than integrated to match publication figures)
  
  #TODO: ^ 
  
  DotPlot(object = dataset, 
          features = features, 
          cols = colors,
          idents = idents,
          split.by  = split_type,
          assay = assay,
          dot.scale = 10) + RotatedAxis()
  
}