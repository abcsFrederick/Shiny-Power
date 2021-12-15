# Two Sample t-test server file

#################### Power Calculation ####################

#' @modified_parameter called String indicating the parameter that was modified by the user
tt_power_calc <- function(modified_parameter)
{
  # map parameters to power.t.test output
  param_map_tt <- c('Effect Size' = 'delta',
                    'SD' = 'sd',
                    'Alpha' = 'sig.level',
                    'Power' = 'power',
                    'N' = 'n')

  # map parameters to names of input fields
  param_map_interface <-  c('Effect Size' = 'tt_delta',
                            'SD' = 'tt_sd',
                            'Alpha' = 'tt_alpha',
                            'Power' = 'tt_power',
                            'N' = 'tt_N')

  # parameters being held constant or directly modified by the user
  const_params <- unique(c(input$tt_hold, modified_parameter))

  ### only one parameter was neither modified by the user nor being held constant in tt_hold ###
  if(length(const_params) == 4)
  {
    retval <- names(param_map_tt)[!names(param_map_tt) %in% const_params]
  }

  ### all parameters were either modified by the user or are being held constant in tt_hold ###
  if(length(const_params) == 5)
  {
    const_params <- const_params[!const_params == modified_parameter]
    retval <- modified_parameter
  }

  ### multiple parameters are neither modified by the user nor being held constant in tt_hold ###
  if(length(const_params) < 4)
  {
    # preferred order for when things are not specified (i.e. usually pick Power if it is unclear)
    ord <- c('Power', 'N', 'Effect Size', 'Alpha', 'SD')
    ord <- ord[! ord %in% const_params]

    retval <- ord[1]
    const_params <- c(const_params, ord[-1])
  }

  # update results
  args <- sapply(const_params, function(.x) as.numeric(input[[param_map_interface[.x]]]), simplify = FALSE)
  names(args) <- param_map_tt[const_params]

  updt <- try(do.call(power.t.test, args)[[param_map_tt[retval]]])

  if(class(updt) != 'try-error')
  {
    if(retval == 'N')
    {
      updt <- ceiling(updt)
    }

    # wrap `inputID` in `unname` to avoid toJSON warning (see https://github.com/rstudio/shiny/issues/2673)
    updateNumericInput(session, unname(param_map_interface[retval]), value = updt)
  }
}

#################### Updates (alphabetized by value) ####################

########## alpha ##########
observeEvent(input$tt_alpha, {
  # check if we updated alpha or if this is run as the result of updating something else
  if(Sys.time() - values$tt_lastupdate > 0.5)
  {
    values$tt_lastupdate <- Sys.time()

    tt_power_calc('Alpha')
  }
  # else (shouldn't get multiple user updates within a half a second) - do nothing
})


########## delta ##########
observeEvent(input$tt_delta, {
  # check if we updated delta or if this is run as the result of updating something else
  if(Sys.time() - values$tt_lastupdate > 0.5)
  {
    values$tt_lastupdate <- Sys.time()

    tt_power_calc('Effect Size')
  }
  # else (shouldn't get multiple user updates within a half a second) - do nothing
})


########## N ##########
observeEvent(input$tt_N, {
  # check if we updated N or if this is run as the result of updating something else
  if(Sys.time() - values$tt_lastupdate > 0.5)
  {
    values$tt_lastupdate <- Sys.time()

    tt_power_calc('N')
  }
  # else (shouldn't get multiple user updates within a half a second) - do nothing
})

########## power ##########
observeEvent(input$tt_power, {
  # check if we updated power or if this is run as the result of updating something else
  if(Sys.time() - values$tt_lastupdate > 0.5)
  {
    values$tt_lastupdate <- Sys.time()

    tt_power_calc('Power')
  }
  # else (shouldn't get multiple user updates within a half a second) - do nothing
})

########## sd ##########
observeEvent(input$tt_sd, {
  # check if we updated alpha or if this is run as the result of updating something else
  if(Sys.time() - values$tt_lastupdate > 0.5)
  {
    values$tt_lastupdate <- Sys.time()

    tt_power_calc('SD')
  }
  # else (shouldn't get multiple user updates within a half a second) - do nothing
})


################################ Graphics ##################################

######### Power Curve #########
output$tt_power_curve <- renderPlot({
  tibble(N = floor(input$tt_plot_min):ceiling(input$tt_plot_max),
         power = power.t.test(n = N,
                              delta = input$tt_delta,
                              sd = input$tt_sd,
                              sig.level = input$tt_alpha)$power) %>%
    ggplot(aes(N, power)) +
    geom_line() +
    geom_hline(yintercept = 0.8, linetype = 'dashed') +
    geom_point(aes(x = input$tt_N, y = input$tt_power), color = 'red') +

    xlab('N (number of samples per group)') +
    labs(caption = paste0('Power (y-axis) as a function of sample size per group (x-axis) when: ',
                          'Effect size = ', input$tt_delta,
                          ', Standard Deviation = ', input$tt_sd,
                          ', and Alpha = ', input$tt_alpha, '.\n',
                          'The red dot indicates the point at which Power = ', input$tt_power,
                          '.\nAt least ', input$tt_N, ' samples are required in each group to achieve ',
                          round(input$tt_power * 100, 1), '% statistical power.'))
})
