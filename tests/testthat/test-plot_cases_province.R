library(ggplot2)
library(tidyr)
China_type <- COVID19CHN::China_covid19 %>%
  
  pivot_longer(cols = c("Confirmed",
                        "Deaths",
                        "Recovered"),
               names_to = "Type",
               values_to = "Cases") 

test_that("plot_cases_province", {
  testthat::expect_true(is.ggplot(plot_cases_province(China_type))
                        
  )
  })

