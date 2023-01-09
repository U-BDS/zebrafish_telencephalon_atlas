#-------------------------------packages------------------------------------------------------
message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Loading packages."))

library(Seurat)
library(cowplot)
library(shiny)
library(shinyjs)
library(ggplot2)
library(markdown)
library(shinyhelper)
library(dplyr)
library(bslib)

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: All packages loaded."))

#--------------------------custom functions---------------------------------------------------
lapply(list.files("./R"), FUN = function(x) source(paste0("./R/", x)))

#--------------------------global objects/variables-----------------------------------------------------
#NOTE: due to simplicity just keeping simple/separate vectors, if needed will mapply all this
# scRNA-seq datasets
message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Reading in integrated forebrain RDS."))
forebrain_integrated <- readRDS(file = "./data/forebrain_integrated_lean.rds")

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Reading in dpf6 RDS."))
dpf6 <- readRDS(file = "./data/dpf6_lean.rds")

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Reading in dpf15 RDS."))
dpf15 <- readRDS(file = "./data/dpf15_lean.rds")

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Reading in adult RDS."))
adult <- readRDS(file = "./data/adult_lean.rds")

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: All RDS data has been loaded."))

# default cols for dotplot
colfunc <- colorRampPalette(c("#F7FCB9","#ADDD8E", "#31A354"))

# default cols for age-split figs (color-blind friendly)
col_split <- c("#F0E442","#56B4E9","#CC79A7")

# custom color palettes per dataset
colors <- as.character(read.csv("./data/custom_colors.csv")$x)
colors_dpf6 <- as.character(read.csv("./data/custom_colors_dpf6.csv")$x)
colors_df15 <- as.character(read.csv("./data/custom_colors_df15.csv")$x)
colors_adult <- as.character(read.csv("./data/custom_colors_adult.csv")$x)

# cluster names for each dataset
message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Reading in integrated forebrain cluster names."))
cluster_names_forebrain_integrated <- levels(forebrain_integrated)

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Reading in dpf6 cluster names."))
cluster_names_dpf6 <- levels(dpf6)

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Reading in dpf15 cluster names."))
cluster_names_dpf15 <- levels(dpf15)

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: Reading in adult cluster names."))
cluster_names_adult <- levels(adult)

message(paste(format(Sys.time(), "(%Y-%m-%d %H:%M:%S %Z)"), "LOG: All cluster names have been loaded."))
