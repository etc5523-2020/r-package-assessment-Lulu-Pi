library(ggplot2)
China_type <- COVID19CHN::China_covid19 %>%
  
  tidyr::pivot_longer(cols = c("Confirmed",
                        "Deaths",
                        "Recovered"),
               names_to = "Type",
               values_to = "Cases") 

test_that("plot_cases_province", {
  testthat::expect_equal(plot_cases_province(China_type),
                         China_type %>%
                         ggplot(aes(x = reorder(China_type$`Province/State`, -China_type$Cases), y = China_type$Cases, 
                                                      fill = China_type$Type)) +
                           geom_bar(stat = "identity", position = "dodge") + 
                           theme_bw() +
                           theme(plot.title = element_text(size = 20, color = "dark red"),
                                          axis.title.x = element_text(size = 15, color = "dark blue"),
                                          axis.title.y = element_text(size = 15, color = "dark blue"),
                                          axis.text.x = element_text(angle = 90, color = "black"),
                                          axis.line = element_line(color = "gray")) +
                           labs(x = "Province", y = "Cases", title = "COVID19 cases per day in China"))
                           
  
})
