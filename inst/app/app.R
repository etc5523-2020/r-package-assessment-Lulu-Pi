# load library
library(shiny)
library(rmarkdown)
library(readr)
library(tidyverse)
library(lubridate)
library(ggplot2)
library(plotly)
library(dplyr)
library(COVID19CHN) # my package
theme_set(theme_classic())

# process dataset

China_type <- COVID19CHN::China_covid19 %>%
  
  pivot_longer(cols = c("Confirmed",
                        "Deaths",
                        "Recovered"),
               names_to = "Type",
               values_to = "Cases") 

table_China <- COVID19CHN::China_covid19 %>%
  select(-Lat, -Long) %>%
  group_by(Date,
           `Province/State`) %>%
  summarise(Confirmed = sum(Confirmed),
            Deaths = sum(Deaths),
            Recovered = sum(Recovered, na.rm = TRUE))



ui <- fluidPage(
  br(),
  h1("This is an app for COVID-19 cases in China"),
  hr(),
  br(), br(),
  fluidRow(column(width = 5),
           h2("About"),
           p(strong("creator of the app: Lulu Pi")),
           p(em("This app is used to analyse the daily cases of COVID-19 in China, including"), strong("Confirmed cases, Death cases and Recovered cases."))),
  br(),
  hr(),
  br(),br(),
  sidebarLayout(
    sidebarPanel(select_provinceInput(China_covid19),
                  radioButtons("Type", "Select",
                               choices = c("Confirmed", "Deaths", "Recovered"),
                               selected = "Confirmed"),
                 htmlOutput("type_province")
                 ),
   mainPanel(plotlyOutput("plot_cases"),
             br(),
             p(em("After selecting, the text output will change as you change the selection, helping you classify which", strong("Province"), em("and"), strong("what type of cases"), em("you are looking for. The figure would present trend of the daily cases change in the Province you select from 2020-1-22 to 2020-9-30, and the plotly label would show you the specific label when you click the point on the figure. "))
             ))),
  br(), br(), br(), br(), 
  hr(),
  br(), br(),
  sidebarLayout(
    sidebarPanel(dateInput("Date", "Select day (up to 2020-9-30)", 
                           min = "2020-1-22", max = "2020-9-30"),
                 dataTableOutput("table")),
    mainPanel(br(), br(),
              plotlyOutput("province_cases"),
              br(),br(), br(), br(), br(),
              p(em("The table of daily"), strong("Cases"), em("in each"), strong("Province"), em("in china would present after you choosing the day in the select-date column. There are multiple methods for you to find the results as soon as possible. You can simply search the specific"), strong("Province"), em("or"), strong("Date"), em("you are looking for by typing in the blank column.")),
              p(em("The plotly figure would appear automatically if you choose a"), strong("Date"), em("within the range, with all type of"), strong("Cases"), em("among all"), strong("Provinces"), em("with a decreasing trend. Same as before, if you click the bar on the figure, the plotly label would show you the"), strong("Provinces"), em("and specific"), strong("Type of cases"), em("on that day.")))
      ))

  
 
  
  


server <- function(input, output, session) {
  output$plot_cases <- renderPlotly({
    element_covid19 <- China_covid19 %>%
      filter(`Province/State` == input$Province)
    g1 <- element_covid19 %>%
      ggplot(aes(Date, get(input$Type))) +
      geom_line(color = "dark green") +
      theme_bw() +
      theme(plot.title = element_text(size = 20, color = "dark red"),
            axis.title.x = element_text(size = 15, color = "blue"),
            axis.title.y = element_text(size = 15, color = "blue"),
            axis.text.x = element_text(angle = 90, color = "black"),
            axis.line = element_line(color = "gray")) +
      scale_x_date(date_breaks = "10 days") +
      labs(x = "Date", y = "Cases", title = input$Province)
    ggplotly(g1)
   
  })
  
  
  output$type_province <- renderUI({
    span(strong("COVID19 cases of", input$Type, "in", input$Province))
    
  })



  output$table <- renderDataTable({
    table_China %>%
      filter(Date == input$Date)
    
  })
  
  output$province_cases <- renderPlotly({
    province_covid19 <- China_type %>%
      filter(Date == input$Date)
    g2 <- plot_cases_province(province_covid19)
    ggplotly(g2)
})
  
  
}


  
  
shinyApp(ui, server)
