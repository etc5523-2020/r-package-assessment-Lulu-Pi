table_China <- COVID19CHN::China_covid19 %>%
  dplyr::select(-Lat, -Long) %>%
  dplyr::group_by(Date,
           `Province/State`) %>%
  dplyr::summarise(Confirmed = sum(Confirmed),
            Deaths = sum(Deaths),
            Recovered = sum(Recovered, na.rm = TRUE))


test_that("select_provinceInput", {

  testthat::expect_equal(select_provinceInput(table_China),
                         shiny::selectInput("Province", "what province do you want to look?",
                                            choices = unique(table_China$`Province/State`),
                                            selected = "Anhui"))
}
          )
  

