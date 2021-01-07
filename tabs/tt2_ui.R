# Two sample t-test with unequal samples UI elements

# copied the code from tt for now, but this needs to be updated...

tabItem(tabName = 'ttest2',
        
        ### Population Parameters ###
        fluidRow(h3("Population Parameters")),
        fluidRow(
            column(1),
            column(9,
                   textInput("tt_delta",
                             "Effect Size",
                             1))
        ),
        fluidRow(
            column(1),
            column(9,
                   textInput("tt_sd",
                             "SD",
                             1))
        ),
        
        ### Error Rates ###
        fluidRow(h3("Target Error Rates"),
                 fluidRow(
                     column(1),
                     column(9,
                            sliderInput('tt_alpha',
                                        HTML('Type I Error (&alpha;)'),
                                        min = 0,
                                        max = 1,
                                        value = 0.05))
                 ),
                 fluidRow(
                     column(1),
                     column(9,
                            sliderInput('tt_power',
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
                         column(9,
                                textInput("tt_N",
                                          "Number of samples per group",
                                          ceiling(power.t.test(delta = 1, power = 0.8)$n)))
                 )
        )
)
