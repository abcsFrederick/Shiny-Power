# server.R for Shiny Power dashboard
library(shiny)
library(shinydashboard)

library(dplyr)

library(ggplot2)
library(cowplot)
theme_set(theme_cowplot())

values <- reactiveValues()
values$tt_lastupdate <- Sys.time()

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    # Two Sample t-test
    eval(parse('tabs/tt_server.R'))

})
