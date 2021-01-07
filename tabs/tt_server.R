# Two Sample t-test server file

# these will be TRUE when observeEvent is called for the objects in the list
tt_updt <- list(tt_alpha = FALSE,
                tt_delta = FALSE,
                tt_N     = FALSE,
                tt_power = FALSE,
                tt_sd    = FALSE)

#################### Updates (alphabetized by value) ####################

########## alpha ##########
observeEvent(input$tt_alpha, {
    tt_updt$tt_alpha <- TRUE
    
    if(sum(unlist(tt_updt)) == 1) # alpha is the first thing to get updated
    {
        tmp <- try(power.t.test(as.numeric(input$tt_N), as.numeric(input$tt_delta), as.numeric(input$tt_sd),
                                input$tt_alpha))
        
        if(class(tmp) != 'try-error')
        {
            updateTextInput(session, 'tt_delta', value = tmp$delta)
            updateTextInput(session, 'tt_N', value = ceiling(tmp$n))
            updateSliderInput(session, 'tt_power', value = tmp$power)
            updateTextInput(session, 'tt_sd', value = tmp$sd)
        }
    }
    # else something else caused this to be updated - do nothing
    
    tt_updt$tt_alpha <- FALSE
})


########## delta ##########
observeEvent(input$tt_delta, {
    tt_updt$tt_delta <- TRUE
    
    if(sum(unlist(tt_updt)) == 1) # delta is the first thing to get updated
    {
        tmp <- try(power.t.test(as.numeric(input$tt_N), as.numeric(input$tt_delta), as.numeric(input$tt_sd),
                                input$tt_alpha))
        
        if(class(tmp) != 'try-error')
        {
            updateSliderInput(session, 'tt_alpha', value = tmp$sig.level)
            updateTextInput(session, 'tt_N', value = ceiling(tmp$n))
            updateSliderInput(session, 'tt_power', value = tmp$power)
            updateTextInput(session, 'tt_sd', value = tmp$sd)
        }
    }
    # else something else caused this to be updated - do nothing
    
    tt_updt$tt_delta <- FALSE
})


########## N ##########
observeEvent(input$tt_N, {
    tt_updt$tt_N <- TRUE
    
    if(sum(unlist(tt_updt)) == 1) # delta is the first thing to get updated
    {
        tmp <- try(power.t.test(as.numeric(input$tt_N), as.numeric(input$tt_delta), as.numeric(input$tt_sd),
                                input$tt_alpha))
        
        if(class(tmp) != 'try-error')
        {
            updateSliderInput(session, 'tt_alpha', value = tmp$sig.level)
            updateTextInput(session, 'tt_delta', value = tmp$delta)
            updateSliderInput(session, 'tt_power', value = tmp$power)
            updateTextInput(session, 'tt_sd', value = tmp$sd)
        }
    }
    # else something else caused this to be updated - do nothing
    
    tt_updt$tt_N <- FALSE
})

########## power ##########
observeEvent(input$tt_power, {
    tt_updt$tt_power <- TRUE
    
    if(sum(unlist(tt_updt)) == 1) # delta is the first thing to get updated
    {
        tmp <- try(power.t.test(delta = as.numeric(input$tt_delta), sd = as.numeric(input$tt_sd), 
                                sig.level = input$tt_alpha, power = input$tt_power))
        
        if(class(tmp) != 'try-error')
        {
            updateSliderInput(session, 'tt_alpha', value = tmp$sig.level)
            updateTextInput(session, 'tt_delta', value = tmp$delta)
            updateTextInput(session, 'tt_N', value = ceiling(tmp$n))
            updateTextInput(session, 'tt_sd', value = tmp$sd)
        }
    }
    # else something else caused this to be updated - do nothing
    
    tt_updt$tt_power <- FALSE
})

########## sd ##########
observeEvent(input$tt_sd, {
    tt_updt$tt_sd <- TRUE
    
    if(sum(unlist(tt_updt)) == 1) # delta is the first thing to get updated
    {
        tmp <- try(power.t.test(as.numeric(input$tt_N), as.numeric(input$tt_delta), as.numeric(input$tt_sd),
                                input$tt_alpha))
        
        if(class(tmp) != 'try-error')
        {
            updateSliderInput(session, 'tt_alpha', value = tmp$sig.level)
            updateTextInput(session, 'tt_delta', value = tmp$delta)
            updateTextInput(session, 'tt_N', value = ceiling(tmp$n))
            updateSliderInput(session, 'tt_power', value = tmp$power)
        }
    }
    # else something else caused this to be updated - do nothing
    
    tt_updt$tt_sd <- FALSE
})
