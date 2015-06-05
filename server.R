library(shiny)
library(ggplot2)
library(ggvis)

#### load in data table, merged from all datasets
clusts=read.table("MergedTable.txt")


### start up Shiny server
shinyServer(function(input, output) {
  # Compute the forumla text in a reactive expression based on user-chosen x and y variables 
  formulaText <- reactive({ paste(input$yvariable,'~',input$xvariable) })
  # Compute a reactive expression for the user-chosen X, Y, and grouping by color of the data
  Xvar <- reactive({ paste(input$xvariable) })
  Yvar <- reactive({ paste(input$yvariable) })  
  grouping <- reactive({ paste(input$Group) })
  
  #### Render the plot!
  reactive({
    ##### Set x and y limits for axes to be slightly beyond the mins and maxs of the x and y range of good data
    Xmin <- reactive({ paste(round(min(clusts[[Xvar()]][clusts[[Xvar()]]!=99.999]) - 0.3*sd(clusts[[Xvar()]][clusts[[Xvar()]]!=99.999]),3)) })
    Xmax <- reactive({ paste(round(max(clusts[[Xvar()]][clusts[[Xvar()]]!=99.999]) + 0.3*sd(clusts[[Xvar()]][clusts[[Xvar()]]!=99.999]),3)) })
    Ymin <- reactive({ paste(round(min(clusts[[Yvar()]][clusts[[Yvar()]]!=99.999]) - 0.3*sd(clusts[[Yvar()]][clusts[[Yvar()]]!=99.999]),3)) })
    Ymax <- reactive({ paste(round(max(clusts[[Yvar()]][clusts[[Yvar()]]!=99.999]) + 0.3*sd(clusts[[Yvar()]][clusts[[Yvar()]]!=99.999]),3)) })
    
    ##### Put it together
    mask=(clusts[[Xvar()]]!=99.999 & clusts[[Yvar()]]!=99.999 & clusts[[grouping()]]!=99.999)# & clusts[[Xvar()]]!=NA & clusts[[Yvar()]]!=NA)
    Xv=clusts[[Xvar()]][mask==TRUE]
    Yv=clusts[[Yvar()]][mask==TRUE]
    Grouping=clusts[[grouping()]][mask==TRUE]

    #### Re-construct data frame
    df1=data.frame(Xv, Yv, Grouping, clusts$Name[mask==TRUE], clusts$Metallicity[mask==TRUE], clusts$RA_hour[mask==TRUE],
                   clusts$RA_mins[mask==TRUE], clusts$RA_secs[mask==TRUE], clusts$Dec_deg[mask==TRUE], clusts$Dec_mins[mask==TRUE],
                   clusts$Dec_secs[mask==TRUE])
    names(df1)=c("Xv", "Yv", "Grouping", "Name", "Metallicity", "RA_hour", "RA_mins", "RA_secs", "Dec_deg", "Dec_mins", "Dec_secs")
    df1$id <- clusts$Name[mask==TRUE]
  
    #### Create hovertext from specific columns - show NGC identification, metallicity, and RA/Dec location
    all_values <- function(x) {
      if(is.null(x)) return(NULL)
      as.character(paste0("NGC ", as.character(df1$Name[df1$id == x$id]),
                  "<br>", "[Fe/H]: ", as.character(df1$Metallicity[df1$id == x$id]),
                  "<br>", "RA: ", as.character(df1$RA_hour[df1$id == x$id]),"h ", as.character(df1$RA_mins[df1$id == x$id]),"m ", as.character(df1$RA_secs[df1$id == x$id]),"s",
                  "<br>", "Dec: ", as.character(df1$Dec_deg[df1$id == x$id]),"d ", as.character(df1$Dec_mins[df1$id == x$id]),"' ", as.character(df1$Dec_secs[df1$id == x$id]), '"' ))
      }
    
    ## Using ggvis, set plot with layers, model, and hover text
    df1 %>% ggvis(~Xv, ~Yv) %>% 
      #### do linear model first so it doesn't block out the hover info for the points
      layer_model_predictions(model = "lm", se = TRUE, opacity:=input_radiobuttons(list("On"=.8,"Off"=0),selected = 0,label="View Linear Fit:")) %>% #opacity:= 0.3 )  %>% #, opacity := 0.1, opacity.hover := 0.7, fillOpacity := 0.1, fillOpacity.hover := 0.7) %>%
      add_axis("x", title = as.character(Xvar())) %>% add_axis("y", title = as.character(Yvar())) %>%
      #### plot the points, with fancy hover aesthetics
      layer_points(fill = ~Grouping, key := ~id, fillOpacity := 0.9, fillOpacity.hover := 0.35) %>%
      add_legend("fill", title = as.character(grouping())) %>%
      #### add the hover information
      add_tooltip(all_values, "hover")
    }) %>% bind_shiny("ggvis","ggvis_ui")  ### bind it up to shiny
  
  
  # Print out the results of the linear fit
  output$showfit <- renderText({
      paste(c("Linear Model = ",formulaText())) #}
  })
  output$showfit2 <- renderText({
      model = lm(as.formula(formulaText()), data=clusts)
      paste(c("Slope =",round(model$coefficients[1],2),
              ",  Intercept =",round(model$coefficients[2],2),
              ", R^2 = ",round(summary(model)$r.squared,2))) #}
  })
    
    
  ##### Summary information for printing in "Data Summary" panel
  output$summaryX <- renderPrint({summary(clusts[[Xvar()]][(clusts[[Xvar()]]!=99.999 & clusts[[Yvar()]]!=99.999 & clusts[[grouping()]]!=99.999)==TRUE])})
  output$summaryY <- renderPrint({summary(clusts[[Yvar()]][(clusts[[Xvar()]]!=99.999 & clusts[[Yvar()]]!=99.999 & clusts[[grouping()]]!=99.999)==TRUE])})
  output$summaryGroup <- renderPrint({summary(clusts[[grouping()]][(clusts[[Xvar()]]!=99.999 & clusts[[Yvar()]]!=99.999 & clusts[[grouping()]]!=99.999)==TRUE])})

  ##### Render text that reflects chosen variable
  output$xvar = renderText({paste(c("Summary of X-axis variable: ", Xvar()))})
  output$yvar = renderText({paste(c("Summary of Y-axis variable:", Yvar()))})
  output$grp = renderText({paste(c("Summary of 'colored-by' variable:", grouping()))})
  
  # Return the formula text for printing as a caption at top of screen
  output$caption <- renderText({formulaText()})

  
})  #end


