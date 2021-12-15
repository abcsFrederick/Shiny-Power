# Two sample t-test UI elements

tabItem(tabName = 'ttest',

    tabsetPanel(
      tabPanel('Parameters',

        ### Population Parameters ###
        fluidRow(h3("Population Parameters")),
        fluidRow(
            column(1),
            column(5,
                   numericInput("tt_delta",
                                "Effect Size",
                                1, min = 0),
                   numericInput("tt_sd",
                                "SD",
                                1, min = 0.001))
        ),

        ### Error Rates ###
        fluidRow(h3("Target Error Rates"),
                 fluidRow(
                     column(1),
                     column(5,
                            numericInput('tt_alpha',
                                         HTML('Type I Error (&alpha;)'),
                                         value = 0.05,
                                         min = 0, max = 1),
                            numericInput('tt_power',
                                         HTML('Power (1 - &beta;)'),
                                         min = 0,
                                         max = 1,
                                         value = 0.8))
                 )
        ),

        ### Sample Size ###
        fluidRow(h3("Sample Size"),
                 fluidRow(
                         column(1),
                         column(5,
                                numericInput("tt_N",
                                             "Number of samples per group",
                                             ceiling(power.t.test(delta = 1, power = 0.8)$n)))
                 )
        ),

        ### Hold Constant ###
        fluidRow(column(4,
               checkboxGroupInput('tt_hold',
                                  'Parameters to hold constant:',
                                  choices = c('Effect Size', 'SD',
                                              'Alpha', 'Power', 'N'),
                                  selected = c('Effect Size', 'SD', 'Alpha')))
      )),

      tabPanel('Power Curve',
        fluidRow(numericInput("tt_plot_min",
                              "Sample Size Minimum",
                              10, min = 3),
                 numericInput("tt_plot_max",
                              "Sample Size Maximum",
                              100, min = 10)),

        plotOutput("tt_power_curve")
      ))
)
