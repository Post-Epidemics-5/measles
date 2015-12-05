library(tidyr)
library(dplyr)
measles_dat <- read.delim("~/Documents/measles-paper/tycho_measles_cities_27Apr2011.txt")

chickenpox <- read.csv("~/Documents/measles-paper/CHICKENPOX_(VARICELLA)_Cases_1923-1981.csv",
                       na.strings="-",
                       skip=2) %>%
  gather("loc", "chickenpox", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, chickenpox)

diphtheria_cases <- read.csv("~/Documents/measles-paper/DIPHTHERIA_Cases_1906-1953.csv",
                             na.strings="-",
                             skip=2) %>%
  gather("loc", "diphtheria_cases", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, diphtheria_cases)

diphtheria_deaths <- read.csv("~/Documents/measles-paper/DIPHTHERIA_Deaths_1888-1981.csv",
                              na.strings="-",
                              skip=2) %>%
  gather("loc", "diphtheria_deaths", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, diphtheria_deaths)

pneumonia_cases <- read.csv("~/Documents/measles-paper/PNEUMONIA_Cases_1912-1923.csv",
                            na.strings="-",
                            skip=2) %>%
  gather("loc", "pneumonia_cases", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, pneumonia_cases)

pneumonia_deaths <- read.csv("~/Documents/measles-paper/PNEUMONIA_Deaths_1912-1948.csv",
                             na.strings="-",
                             skip=2) %>%
  gather("loc", "pneumonia_deaths", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, pneumonia_deaths)

scarlet_cases <- read.csv("~/Documents/measles-paper/SCARLET_FEVER_Cases_1906-1948.csv",
                          na.strings="-",
                          skip=2) %>%
  gather("loc", "scarlet_cases", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, scarlet_cases)

scarlet_deaths <- read.csv("~/Documents/measles-paper/SCARLET_FEVER_Deaths_1900-1923.csv",
                           na.strings="-",
                           skip=2) %>%
  gather("loc", "scarlet_deaths", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, scarlet_deaths)

tb_cases <- read.csv("~/Documents/measles-paper/TUBERCULOSIS_(PHTHISIS_PULMONALIS)_Cases_1906-2014.csv",
                     na.strings="-",
                     skip=2) %>%
  gather("loc", "tb_cases", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, tb_cases)

tb_deaths <- read.csv("~/Documents/measles-paper/TUBERCULOSIS_(PHTHISIS_PULMONALIS)_Deaths_1890-1941.csv",
                      na.strings="-",
                      skip=2) %>%
  gather("loc", "tb_deaths", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, tb_deaths)


typhoid_cases <- read.csv("~/Documents/measles-paper/TYPHOID_FEVER_(ENTERIC_FEVER)_Cases_1906-1953.csv",
                          na.strings="-",
                          skip=2) %>%
  gather("loc", "typhoid_cases", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, typhoid_cases)

typhoid_deaths <- read.csv("~/Documents/measles-paper/TYPHOID_FEVER_(ENTERIC_FEVER)_Deaths_1887-1932.csv",
                           na.strings="-",
                           skip=2) %>%
  gather("loc", "typhoid_deaths", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, typhoid_deaths)

whooping_cases <- read.csv("~/Documents/measles-paper/WHOOPING_COUGH_(PERTUSSIS)_Cases_1906-1953.csv",
                           na.strings="-",
                           skip=2) %>%
  gather("loc", "whooping_cases", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, whooping_cases)

whooping_deaths <- read.csv("~/Documents/measles-paper/WHOOPING_COUGH_(PERTUSSIS)_Deaths_1888-1910.csv",
                            na.strings="-",
                            skip=2) %>%
  gather("loc", "whooping_deaths", 3:57) %>%
  mutate(locstate = gsub(replacement="-", pattern="\\.\\.", loc)) %>%
  select(locstate, year=YEAR, week=WEEK, whooping_deaths)

all_diseases <- left_join(measles_dat, chickenpox) %>%
  left_join(diphtheria_cases) %>%
  left_join(diphtheria_deaths) %>%
  left_join(pneumonia_cases) %>%
  left_join(pneumonia_deaths) %>%
  left_join(scarlet_cases) %>%
  left_join(scarlet_deaths) %>%
  left_join(tb_cases) %>%
  left_join(tb_deaths) %>%
  left_join(typhoid_cases) %>%
  left_join(typhoid_deaths)  %>%
  left_join(whooping_cases) %>%
  left_join(whooping_deaths)


saveRDS(all_diseases, "all-diseases.rds")
