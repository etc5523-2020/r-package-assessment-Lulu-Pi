#' Launch the shiny app for COVID-19 in China.
#' 
#' @description Runs the Shiny app which can help you analyse the daily cases of COVID-19 among all provinces in China, 
#' including confirmed cases, Death cases and Recovered cases from 22 January 2020 to 30 September 2020.
#'

#' @return A shiny application for COVID-19 cases in China.
#' 
#' @import shiny
#' 
#' @export
#'
launch_app <- function(){
  appDir <- system.file("app", "app.R", package = "COVID19CHN")
  if(appDir == ""){
    stop("Could not find example directory. Try re-installing `COVID19CHN` package")
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}