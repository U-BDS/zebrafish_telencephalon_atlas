#-------------------------------packages-------------------------------------
library(Seurat)
library(cowplot)
library(shiny)
library(shinyjs)
library(ggplot2)
library(markdown)
library(shinyhelper)
library(dplyr)

#--------------------------custom functions----------------------------------
lapply(list.files("./R"), FUN = function(x) source(paste0("./R/", x)))

#--------------------------global objects------------------------------------
# scRNA-seq datasets
forebrain_integrated <- readRDS(file = "./data/forebrain_integrated_lean.rds")
dpf6 <- readRDS(file = "./data/dpf6_lean.rds") 
dpf15 <- readRDS(file = "./data/dpf15_lean.rds")
adult <- readRDS(file = "./data/adult_lean.rds")

# custom color palettes per dataset
colors <- as.character(read.csv("./data/custom_colors.csv")$x)
colors_dpf6 <- as.character(read.csv("./data/custom_colors_dpf6.csv")$x)
colors_df15 <- as.character(read.csv("./data/custom_colors_df15.csv")$x)
colors_adult <- as.character(read.csv("./data/custom_colors_adult.csv")$x)

