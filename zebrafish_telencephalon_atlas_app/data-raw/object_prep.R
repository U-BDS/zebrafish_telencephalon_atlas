#### object prep ####
# this script contains brief steps performed to prepare object implemented in the app
# along with some brief checks and visualization for general familiarity with provided data

library(Seurat)

#### load objects provided to U-BDS ####

load(file = "./data/forebrain_all_final.RObj")

############## INTEGRATED OBJECT #################

#### rename idents ####
# the following code was provided by the Thyme lab for minor modifications in the shared object

forebrain.integrated <- RenameIdents(object = forebrain.integrated, `UnK` = "NK-like")
forebrain.integrated <- RenameIdents(object = forebrain.integrated, `Astrocytes` = "Astrocyte-like")

# will add a new meta.col to reflect all new Idents (leaving original alone)
forebrain.integrated$CellType <- Idents(forebrain.integrated)

# set wanted order by the lab
cluster_order <- c('dHabenula', 'vHabenula', 'Microglia', 'OPC', 'Oligodendrocytes', 'Olfactory Bulb',
                   'Progenitor_02', 'Progenitor_01','NK-like', 'Epithelial/Endothelial Cells', 'Cycling progenitors_01', 'Cycling progenitors_02', 
                   'Committed_pallium_precursors', 'Committed_subpallium_precursors', 
                   'Pallium_IN01', 'Pallium_IN02', 'Subpallium_IN', 'Subpallium_03',
                   'Pallium_01', 'Pallium_02', 'Pallium_03', 'Pallium_04', 'Pallium_05', 'Pallium_06', 'Pallium_07', 'Pallium_08', 'Pallium_09',
                   'Subpallium_01', 'Subpallium_02', 'PoA_02', 'Subpallium_04', 'Subpallium_05', 'Subpallium_06', 
                   'Subpallium_07', 'Subpallium_08', 'PoA_01', 'Astrocyte-like','Pallium_IN03')

levels(forebrain.integrated) <- cluster_order

#### save custom color pallet ####

# recoloring clusters by lab-provided colors
colors <- c('grey', 'grey64', 'mistyrose2', 'chartreuse1' , 'chocolate3', 'deepskyblue1', 
            'rosybrown3','gold1', 'orange1', 'sandybrown', 'coral', 'navajowhite1',
            'lightsteelblue2', 'darkseagreen1', 
            'lightcyan1', 'darkslategray1', 'pink1', 'thistle1',
            'cyan4', 'blue1', 'darkturquoise', 'yellowgreen', 'mediumspringgreen', 'lightskyblue', 'royalblue1', 'green1', 'magenta1',
            'purple','lightcoral', 'orchid1', 'palevioletred1', 'darkviolet', 'maroon1', 
            'tomato1', 'slateblue1','red','burlywood2','olivedrab1')

# hex8 colors
colors <- as.character(sapply(colors, adjustcolor, alpha = 1.0))

write.csv(colors, "./data/custom_colors.csv", row.names = FALSE)

# plot with new colors (a quick test)
DimPlot(forebrain.integrated, cols = colors, label = TRUE, pt.size = 0.6)

##### DietSeurat #####
forebrain_integrated_lean <- DietSeurat(forebrain.integrated, counts = FALSE, data = TRUE, scale.data = FALSE, 
                                        assay = c("RNA","integrated"), dimreducs = c("pca","umap"))

# save as new RDS objects
saveRDS(forebrain_integrated_lean, file = "./data/forebrain_integrated_lean.rds", compress = FALSE) 

############## dpf6 OBJECT #################
# levels / order in age-specific objects are seurat clusters

load(file = "./data/dpf6.RObj")

identical(dpf6@meta.data$seurat_clusters, dpf6@meta.data$RNA_snn_res.1.7) #TRUE

#### save custom color pallet for dpf6 ####

# recoloring clusters by lab-provided colors
colors_dpf6 <- c('tomato1', 'slateblue1', 'blue1', 'maroon1' , 'lightskyblue', 'yellowgreen', 
                 'plum1','lightcyan1', 'magenta1', 'pink1', 'red',
                 'grey','navajowhite1','coral','darkturquoise','paleturquoise2',
                 'mediumspringgreen','gold1','olivedrab1','darkslategray1','burlywood2',
                 'sandybrown','lightcyan2','lightcoral','deepskyblue1','cyan4',
                 'darkorange2', 'grey64','mistyrose2','darksalmon','firebrick',
                 'deepskyblue3', 'chartreuse1')

# hex8 colors
colors_dpf6 <- as.character(sapply(colors_dpf6, adjustcolor, alpha = 1.0))

write.csv(colors_dpf6, "./data/custom_colors_dpf6.csv", row.names = FALSE)

# brief UMAP check
DimPlot(dpf6, cols = colors_dpf6, label = TRUE, pt.size = 0.6)


##### DietSeurat #####
dpf6_lean <- DietSeurat(dpf6, counts = FALSE, data = TRUE, scale.data = FALSE, 
                        assay = c("RNA","integrated"), dimreducs = c("pca","umap"))

# save as new RDS objects
saveRDS(dpf6_lean, file = "./data/dpf6_lean.rds", compress = FALSE) 

############## df15 OBJECT #################
# levels / order in age-specific objects are seurat clusters

load(file = "./data/dpf15.RObj")

identical(dpf15@meta.data$seurat_clusters, dpf15@meta.data$RNA_snn_res.1.7) #TRUE

#### save custom color pallet for df15 ####

# recoloring clusters by lab-provided colors
colors_df15 <- c('magenta1', 'tomato1', 'pink1', 'lightskyblue' , 'maroon1', 'springgreen3', 
               'lightcyan2','darkturquoise', 'mediumspringgreen', 'yellowgreen', 'navajowhite1',
               'lightcoral','blue1','lightskyblue2','slateblue1','lightcyan1',
               'paleturquoise2','coral','grey','thistle1','darkslategray1',
               'darkviolet','burlywood2','olivedrab1','lightsalmon','olivedrab',
               'deepskyblue1', 'sandybrown','darksalmon','mistyrose2','firebrick4')

# hex8 colors
colors_df15 <- as.character(sapply(colors_df15, adjustcolor, alpha = 1.0))

write.csv(colors_df15, "./data/custom_colors_df15.csv", row.names = FALSE)

# brief UMAP check
DimPlot(dpf15, cols = colors_df15, label = TRUE, pt.size = 0.6)

##### DietSeurat #####
dpf15_lean <- DietSeurat(dpf15, counts = FALSE, data = TRUE, scale.data = FALSE, 
                        assay = c("RNA","integrated"), dimreducs = c("pca","umap"))

# save as new RDS objects
saveRDS(dpf15_lean, file = "./data/dpf15_lean.rds", compress = FALSE) 

############## adult OBJECT #################
# levels / order in age-specific objects are seurat clusters

load(file = "./data/adult.RObj")

identical(ADULT@meta.data$seurat_clusters, ADULT@meta.data$RNA_snn_res.1.6) #TRUE


#### save custom color pallet for adult ####

# recoloring clusters by lab-provided colors

colors_adult <- c('tomato1', 'darkviolet', 'springgreen3', 'lightskyblue' , 'mediumspringgreen', 'royalblue1', 
                  'blue1','darkturquoise', 'lightskyblue1', 'lightskyblue3', 'springgreen2',
                  'maroon1', 'maroon3', 'yellowgreen', 'red','tomato3',
                  'grey64','chartreuse1','navajowhite1','turquoise1','palegreen',
                  'saddlebrown','burlywood2','orange1','lightcyan1','mistyrose2',
                  'steelblue3', 'sandybrown', 'mistyrose3', 'darksalmon', 'chartreuse3',
                  'peru', 'gold1', 'chocolate3','rosybrown3','firebrick3')

# hex8 colors
colors_adult <- as.character(sapply(colors_adult, adjustcolor, alpha = 1.0))

write.csv(colors_adult, "./data/custom_colors_adult.csv", row.names = FALSE)

# brief UMAP check
DimPlot(ADULT, cols = colors_adult, label = TRUE, pt.size = 0.6)

##### DietSeurat #####
adult_lean <- DietSeurat(ADULT, counts = FALSE, data = TRUE, scale.data = FALSE, 
                         assay = c("RNA","integrated"), dimreducs = c("pca","umap"))

# save as new RDS objects
saveRDS(adult_lean, file = "./data/adult_lean.rds", compress = FALSE) 
