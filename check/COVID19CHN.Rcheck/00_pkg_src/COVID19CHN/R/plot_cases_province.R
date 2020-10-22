#' Plot the bar chart of all the provinces with daily cases in a dateset 
#' 
#' @description Creates a bar chart to present all types of daily cases in all provinces.
#'
#' @param data A dataset containing `Province/State` and `Type` of `Cases` in columns. 
#' 
#' @return A ggplot bar chart of COVID-19 with `type of cases` in three colors among all `provinces` on a specific day.
#' 
#' @importFrom magrittr %>% 
#' @importFrom stats reorder
#' 
#' @export
#'
plot_cases_province <- function(data) {
  data %>%
    ggplot2::ggplot(ggplot2::aes(x = reorder(data$`Province/State`, -data$Cases), y = data$Cases, fill = data$Type)) +
    ggplot2::geom_bar(stat = "identity", position = "dodge") + 
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(size = 20, color = "dark red"),
                   axis.title.x = ggplot2::element_text(size = 15, color = "dark blue"),
                   axis.title.y = ggplot2::element_text(size = 15, color = "dark blue"),
                   axis.text.x = ggplot2::element_text(angle = 90, color = "black"),
                   axis.line = ggplot2::element_line(color = "gray")) +
    ggplot2::labs(x = "Province", y = "Cases", title = "COVID19 cases per day in China")
}