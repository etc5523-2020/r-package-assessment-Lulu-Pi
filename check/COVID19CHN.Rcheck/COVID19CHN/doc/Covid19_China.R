## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = FALSE, warning = FALSE, message=FALSE,
  collapse = TRUE,
  comment = "#>",
  out.width = "100%"
)

## ----setup, echo=TRUE---------------------------------------------------------
library(COVID19CHN)

## ---- echo=TRUE, eval = FALSE-------------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("etc5523-2020/r-package-assessment-Lulu-Pi")

## ---- echo=TRUE, eval=FALSE---------------------------------------------------
#  launch_app()

## -----------------------------------------------------------------------------
library(glue)
glue_collapse(unique(China_covid19$`Province/State`), sep = ", ", last = " and ")

