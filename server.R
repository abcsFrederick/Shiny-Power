# server.R for Shiny Power dashboard
library(shiny)
library(shinydashboard)


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {

    # Two Sample t-test
    eval(parse('tabs/tt_server.R'))
    
})
