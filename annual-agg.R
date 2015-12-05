library(dplyr)
library(tidyr)
library(ggplot2)

all_diseases <- readRDS("all-diseases.rds")


unique(all_diseases$locstate)

qplot()

annual_diseases <- all_diseases %>%
  select(-epi_week) %>%
  group_by(locstate, year, pop) %>%
  summarise(cases = sum(cases, na.rm=T),
            chickenpox = ifelse(length(which(is.na(chickenpox)))==n(),NA,sum(chickenpox, na.rm=T)),
            diphtheria_cases = ifelse(length(which(is.na(diphtheria_cases)))==n(),NA,sum(diphtheria_cases, na.rm=T)),
            diphtheria_deaths = ifelse(length(which(is.na(diphtheria_deaths)))==n(),NA,sum(diphtheria_deaths, na.rm=T)),
            pneumonia_cases = ifelse(length(which(is.na(pneumonia_cases)))==n(),NA,sum(pneumonia_cases, na.rm=T)),
            pneumonia_deaths = ifelse(length(which(is.na(pneumonia_deaths)))==n(),NA,sum(pneumonia_deaths, na.rm=T)),
            scarlet_cases = ifelse(length(which(is.na(scarlet_cases)))==n(),NA,sum(scarlet_cases, na.rm=T)),
            scarlet_deaths = ifelse(length(which(is.na(scarlet_deaths)))==n(),NA,sum(scarlet_deaths, na.rm=T)),
            tb_cases = ifelse(length(which(is.na(tb_cases)))==n(),NA,sum(tb_cases, na.rm=T)),
            tb_deaths = ifelse(length(which(is.na(tb_deaths)))==n(),NA,sum(tb_deaths, na.rm=T)),
            typhoid_cases = ifelse(length(which(is.na(typhoid_cases)))==n(),NA,sum(typhoid_cases, na.rm=T)),
            typhoid_deaths = ifelse(length(which(is.na(typhoid_deaths)))==n(),NA,sum(typhoid_deaths, na.rm=T)),
            whooping_cases = ifelse(length(which(is.na(whooping_cases)))==n(),NA,sum(whooping_cases, na.rm=T)),
            whooping_deaths = ifelse(length(which(is.na(whooping_deaths)))==n(),NA,sum(whooping_deaths, na.rm=T)))
  
saveRDS(annual_diseases, "annual-diseases.rds")
