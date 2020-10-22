#' Plot the bar chart of all the provinces with daily cases in a dateset 
#' 
#' @description Creates a bar chart to present all types of daily cases in all provinces.
#'
#' @param data A dataset containing `Province/State` and `Type` of `Cases` in columns. 
#' 
#' @return A ggplot bar chart of COVID-19 with `type of cases` in three colors among all `provinces` on a specific day.
#' 
#' @import ggplot2
#' @export
#'
plot_cases_province <- function(data) {
  data %>%
    ggplot2::ggplot(aes(x = reorder(`Province/State`, -Cases), y = Cases, fill = Type)) +
    geom_bar(stat = "identity", position = "dodge") + 
    theme_bw() + 
    theme(plot.title = element_text(size = 20, color = "dark red"),
          axis.title.x = element_text(size = 15, color = "dark blue"),
          axis.title.y = element_text(size = 15, color = "dark blue"),
          axis.text.x = element_text(angle = 90, color = "black"),
          axis.line = element_line(color = "gray")) +
    labs(x = "Province", y = "Cases", title = "COVID19 cases per day in China")
}