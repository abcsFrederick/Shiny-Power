# ui.R for Shiny Power dashboard
library(shiny)
library(shinydashboard)

dashboardPage(
    #################### Header ####################
    dashboardHeader(title = "Shiny Power Dashboard", titleWidth = 400),
    
    #################### Sidebar ####################
    dashboardSidebar(
        sidebarMenu(
            menuItem("Two Sample t-test", tabName = 'ttest')
        )
    ),
    
    #################### Body ####################
    dashboardBody(tabItems(
        
        ########## Two Sample t-test ##########
        eval(parse(file = ('tabs/tt_ui.R')))
    ))
)
