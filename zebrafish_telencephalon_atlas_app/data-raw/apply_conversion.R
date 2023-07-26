# apply convert_assay_v5 across all existing datasets

library(BPCells)
library(Seurat)
library(SeuratObject)

options(Seurat.object.assay.version = "v5")
source("./data-raw/convert_assay_v5.R")

# load all objects

forebrain_integrated <- readRDS(file = "./data/forebrain_integrated_lean.rds")
dpf6 <- readRDS(file = "./data/dpf6_lean.rds")
dpf15 <- readRDS(file = "./data/dpf15_lean.rds")
adult <- readRDS(file = "./data/adult_lean.rds")

# run convert_assay_v5 to save updated Seurat objects.
# this is done once per assay to be kept
# NOTE: for cases where we do 2 conversions the on-disk data directory is copied
# into the latest run (only need to retain the latest run)

#------------------------------ convert --------------------------------------
# calling is separately - each run has a different name  etc... and a one timer, so keeping it simple

### forebrain_integrated ####

# RNA
convert_assay_v5(dataset = forebrain_integrated, assay = "RNA",
                 tmp_output_path = "./data/TMPS/forebrain_integrated_RNA",
                 seurat_output_path = "./data/TMPS/forebrain_integrated_TMP_RNA", # RNA only
                 updated_dataset_name = "forebrain_integrated_assay5_TMP.rds")

rm(forebrain_integrated)
forebrain_integrated <- readRDS("./data/TMPS/forebrain_integrated_TMP_RNA/forebrain_integrated_assay5_TMP.rds")

# integrated
convert_assay_v5(dataset = forebrain_integrated, assay = "integrated",
                 tmp_output_path = "./data/TMPS/forebrain_integrated_integrated",
                 seurat_output_path = "./data/on_disk/forebrain_integrated", # RNA + integrated, final
                 updated_dataset_name = "forebrain_integrated_assay5.rds")


### dpf6 ####

# RNA
convert_assay_v5(dataset = dpf6, assay = "RNA",
                 tmp_output_path = "./data/TMPS/dpf6_RNA",
                 seurat_output_path = "./data/TMPS/dpf6_TMP_RNA", # RNA only
                 updated_dataset_name = "dpf6_assay5_TMP.rds")

rm(dpf6)
dpf6 <- readRDS("./data/TMPS/dpf6_TMP_RNA/dpf6_assay5_TMP.rds")

# integrated
convert_assay_v5(dataset = dpf6, assay = "integrated",
                 tmp_output_path = "./data/TMPS/dpf6_integrated",
                 seurat_output_path = "./data/on_disk/dpf6", # RNA + integrated, final
                 updated_dataset_name = "dpf6_assay5.rds")

### dpf15 ####

# RNA
convert_assay_v5(dataset = dpf15, assay = "RNA",
                 tmp_output_path = "./data/TMPS/dpf15_RNA",
                 seurat_output_path = "./data/TMPS/dpf15_TMP_RNA", # RNA only
                 updated_dataset_name = "dpf15_assay5_TMP.rds")

rm(dpf15)
dpf15 <- readRDS("./data/TMPS/dpf15_TMP_RNA/dpf15_assay5_TMP.rds")

# integrated
convert_assay_v5(dataset = dpf15, assay = "integrated",
                 tmp_output_path = "./data/TMPS/dpf15_integrated",
                 seurat_output_path = "./data/on_disk/dpf15", # RNA + integrated, final
                 updated_dataset_name = "dpf15_assay5.rds")

### adult ####

# RNA
convert_assay_v5(dataset = adult, assay = "RNA",
                 tmp_output_path = "./data/TMPS/adult_RNA",
                 seurat_output_path = "./data/TMPS/adult_TMP_RNA", # RNA only
                 updated_dataset_name = "adult_assay5_TMP.rds")

rm(adult)
adult <- readRDS("./data/TMPS/adult_TMP_RNA/adult_assay5_TMP.rds")

# integrated
convert_assay_v5(dataset = adult, assay = "integrated",
                 tmp_output_path = "./data/TMPS/adult_integrated",
                 seurat_output_path = "./data/on_disk/adult", # RNA + integrated, final
                 updated_dataset_name = "adult_assay5.rds")

