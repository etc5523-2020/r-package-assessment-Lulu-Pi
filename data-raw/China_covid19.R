## code to prepare `China_covid19` dataset goes here 

library(rmarkdown)
library(readr)
library(tidyverse)
library(lubridate)
library(hrbrthemes)
library(dplyr)

# select confirmed cases in China from 1/22/2020 to 9/30/2020
confirmed <- read_csv("data-raw/covid19_confirmed_global.csv") %>%
  filter(`Country/Region` == "China") %>%
  pivot_longer(cols = "1/22/2020":"9/30/2020",
               names_to = "Date",
               values_to = "Confirmed") %>%
  select(-"Country/Region") %>% 
  mutate(Date = mdy(Date))

# select deaths cases in China from 1/22/2020 to 9/30/2020
deaths <- read_csv("data-raw/covid19_deaths_global.csv") %>%
  filter(`Country/Region` == "China") %>%
  pivot_longer(cols = "1/22/2020":"9/30/2020",
               names_to = "Date",
               values_to = "Deaths") %>%
  select(-"Country/Region") %>% 
  mutate(Date = mdy(Date))

# select recovered cases in China from 1/22/2020 to 9/30/2020
recovered <- read_csv("data-raw/covid19_recovered_global.csv") %>%
  filter(`Country/Region` == "China") %>%
  pivot_longer(cols = "1/22/2020":"9/30/2020",
               names_to = "Date",
               values_to = "Recovered") %>%
  select(-"Country/Region") %>% 
  mutate(Date = mdy(Date))

# joined confirmed, deaths and recovered cases in one table
China_covid19 <- confirmed %>%
  left_join(deaths,
            by = c("Date", 
                   "Province/State",
                   "Lat",
                   "Long"))%>%
  left_join(recovered,
            by = c("Date", 
                   "Province/State",
                   "Lat",
                   "Long"))%>% 
  mutate(Month = month(Date))


usethis::use_data(China_covid19, overwrite = TRUE)

