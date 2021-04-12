# detrend all MeA and BuS corres according to recommondations of reviewer 2 in LADE-PICE paper
# fixed instead of 2/3 spline in stochastic detrending 
# Regional curve standardization (mean curve after alignment according to biological age)

library(zoo)
library(tidyverse)
library(lubridate) 
library(rlang)
library(readxl)
library(stringr)
library(treeclim)
library(dplR)
library(detrendeR)

# Clears workspace
remove(list = ls())
Sys.setenv(TZ = "GMT") # sets the system time to GMT

# load x-dated BuS tree ring data
l_treemeans_BuS <- read_csv("tree_core_data_Buscarini/cofecha_Obn/l_cor_treemeans_in_chron.csv")[,-1]
names(l_treemeans_BuS)
l_treemeans_BuS %>% distinct(sample, site, type) %>% print(n=Inf)
unique(l_treemeans_BuS$sample); unique(l_treemeans_BuS$site); unique(l_treemeans_BuS$type)

unique(l_treemeans_BuS[duplicated(l_treemeans_BuS), ]$site)
l_treemeans_BuS <- l_treemeans_BuS[!duplicated(l_treemeans_BuS), ]

# load x-dated MeA tree ring data
LADE_MeA_E <- read_csv("tree_core_data_Meurer/LARIX_Einzelbaeume_F.csv")
LADE_MeA_L <- read_csv("tree_core_data_Meurer/LARIX_Einzelbaeume_S.csv")
LADE_MeA_T <- read_csv("tree_core_data_Meurer/LARIX_Einzelbaeume_G.csv")

PICE_MeA_E <- read_csv("tree_core_data_Meurer/PINUS_Einzelbaeume_F.csv")
PICE_MeA_L <- read_csv("tree_core_data_Meurer/PINUS_Einzelbaeume_S.csv")
PICE_MeA_T <- read_csv("tree_core_data_Meurer/PINUS_Einzelbaeume_G.csv")

(l_LADE_MeA_E <- LADE_MeA_E %>% 
  pivot_longer(-Year, names_to = "sample", values_to = "RW"))
(l_LADE_MeA_L <- LADE_MeA_L %>% 
    pivot_longer(-Year, names_to = "sample", values_to = "RW"))
(l_LADE_MeA_T <- LADE_MeA_T %>% 
    pivot_longer(-Year, names_to = "sample", values_to = "RW"))

(l_PICE_MeA_E <- PICE_MeA_E %>% 
    pivot_longer(-Year, names_to = "sample", values_to = "RW"))
(l_PICE_MeA_L <- PICE_MeA_L %>% 
    pivot_longer(-Year, names_to = "sample", values_to = "RW"))
(l_PICE_MeA_T <- PICE_MeA_T %>% 
    pivot_longer(-Year, names_to = "sample", values_to = "RW"))

l_treemeans_MeA <- bind_rows()