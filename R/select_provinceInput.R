#' Selection of provinces for users in app
#' 
#' @description Creates selection input in shiny package for users to choose which province they want to check with.
#'
#' @param data A dataset containing `Province/State` in columns. 
#' 
#' @return A shiny drop down menu with all provinces in data set.
#' 
#' @import shiny
#' @export
#'
select_provinceInput <- function(data) {
  province <- unique(data$`Province/State`)
    
  shiny::selectInput("Province", "what province do you want to look?",
                     choices = province,
                     selected = "Anhui")
}

