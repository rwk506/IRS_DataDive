library(shiny)
library(ggplot2)
library(ggvis)


#### load in data table, merged from all datasets
#DF = read.csv('/Users/Rachel/Desktop/DataDive/irs990_full.csv', nrows = 10000)
#unqNTEE = unique(DF$NTEE_topcode)
#unqNTEE = na.omit(unqNTEE)

# Section VIII - Revenue
# totcntrbgfts: Total contributed donations for the organization
# grsincfndrsng: Gross income from fundraising
# lessdirfndrsng: Fundraising expenses
# netincfndrsng: Net income from fundraising
# totprgmrevnue: Total revenue from program services
# noindiv100kcnt: No. of individuals gaining >100k
# nocontractor100kcnt: No. of contractors gaining >100k
# totcomprelatede: Sum of reportable compensation from highest paid employees/directors/trustees/officers from other organizations
# totestcompf: Sum of other compensation (not reportable?)
# totrevenue: Total reported revenue
# also there's the NTEE/name info

DF = read.csv('./taxform_short.csv')
DF$YrsOld = 2016 - DF$FormYear
DF$tmp = DF$totcntrbgfts/DF$totrevenue

merge_ggvis <- function(...) {
  vis_list <- list(...)
  out <- do.call(Map, c(list(`c`), vis_list))
  attributes(out) <- attributes(vis_list[[1]])
  out
}

TEST = read.csv('./test.csv')


### start up Shiny server
shinyServer(function(input, output) {
  
  ### allow user to download "test.csv" file
  output$downloadData <- downloadHandler(
    filename = function() { paste('test', '.csv', sep='') },
    content = function(file) {
      write.table(TEST, file, row.names=FALSE, col.names=FALSE, sep=',')})
  
  # Compute the forumla text in a reactive expression based on user-chosen x and y variables 
  formulaText <- reactive({ paste(input$yvariable,'~',input$xvariable) })
  # Compute a reactive expression for the user-chosen X, Y, and grouping by color of the data
  Xvar <- reactive({ paste(input$xvariable) })
  Yvar <- reactive({ paste(input$yvariable) })
  
  userData <- reactive({
      # input$file1 will be NULL initially. After the user selects and uploads a file, it will be a data frame with 'name',
      # 'size', 'type', and 'datapath' columns. The 'datapath' column will contain the local filenames where the data can
      # be found.
      inFile <- input$file1
      if (is.null(inFile))
        return(NULL)
      USERdata = read.csv(inFile$datapath)#, header = input$header)
      
      names(USERdata) = c("yr", "totcontrib", "totrev")
      USERdata$form = 2016 - USERdata$yr
      USERdata$ratio = USERdata$totcontrib/USERdata$totrev
      
      
      USERdata
    })
  
  output$contents <- renderDataTable({ userData() })
  
  
  
  #### Render the plot!
  reactive({
    ##### Put it together     #### Re-construct data frame
     Xv=DF$YrsOld[(DF$grsincfndrsng>10)&(DF$NTEE_topname==as.character(Xvar()))]
     Yv=DF$tmp[(DF$grsincfndrsng>10)&(DF$NTEE_topname==as.character(Xvar()))]
     ntee = DF$NTEE_topcode[(DF$grsincfndrsng>10)&(DF$NTEE_topname==as.character(Xvar()))]
     DF1 = data.frame(Xv, Yv, ntee)
     names(DF1) = c("Xv", "Yv", "ntee")
     
     MEDS = aggregate(DF1$Yv, by=list(DF1$Xv), FUN=median)
     names(MEDS) = c("year","med")
     #### add a count/std for error bars?
     
    #### Create hovertext from specific columns - show NGC identification, metallicity, and RA/Dec location
    all_values <- function(x) {
      if(is.null(x)) return(NULL)
      as.character(paste0(#DF$NTEEtop,
                          "<br>", "Age: ", as.character(MEDS$year[MEDS$year == x$year]), ' yrs',  #[DF$NTEE_topcode == x$ntee]),  ### needs to equal id or whatever for ind points - otherwise avg
                          "<br>", "Ratio: ", as.character(round(MEDS$med[MEDS$year == x$year],digits=3))#DF$tmp[DF$NTEE_topcode == x$ntee])
                          ))}

    ## Add summary table to other tab
    #output$xvar = renderText({paste(c("Summary of X-axis variable: ", MEDS))})
    output$table <- renderDataTable(MEDS, 
                    options = list(pageLength = 25))#, initComplete = I("function(settings, json) {alert('Done.');}")))
                                    
    ## Using ggvis, set plot with layers, model, and hover text
    p1 = MEDS %>% ggvis(~year, ~med)  %>%
      #### do linear model first so it doesn't block out the hover info for the points
      layer_model_predictions(model = "loess", se = TRUE, stroke:= "blue", fill:='blue', fillOpacity := 0.5, fillOpacity.hover := 0.15) %>% #,  opacity:=input_radiobuttons(list("On"=.8,"Off"=0),selected = 0,label="View Fit:")) %>% #opacity:= 0.3 )  %>% #, opacity := 0.1, opacity.hover := 0.7, fillOpacity := 0.1, fillOpacity.hover := 0.7) %>%
      add_axis("x", title = 'Age of Organization') %>% 
      add_axis("y", title = 'Ratio - Donated Contributions to Total Revenue') %>%
      scale_numeric("x", domain = c(0, 120), nice = FALSE, clamp = TRUE) %>%
      scale_numeric("y", domain = c(0, 1), nice = FALSE, clamp = TRUE) %>%
      #### plot the points, with fancy hover aesthetics
      layer_points(fill:='blue', fillOpacity := 0.75, fillOpacity.hover := 0.35) %>%
      # add_legend("fill", title = as.character(grouping())) %>%
      #### add the hover information
      add_tooltip(all_values, "hover")
    
    ##### for user-input data !
    all_values2 <- function(x) {
      if(is.null(x)) return(NULL)
      as.character(paste0(
        "<br>", "Age: ", as.character(userData()$form[userData()$yr == x$yr]), ' yrs',  #[DF$NTEE_topcode == x$ntee]),  ### needs to equal id or whatever for ind points - otherwise avg
        "<br>", "Ratio: ", as.character(round(userData()$ratio[userData()$yr == x$yr],digits=3))#DF$tmp[DF$NTEE_topcode == x$ntee])
      ))}
    if(is.null(userData())){
      p2 = (data.frame(x = 0, y = 0) %>% ggvis(~x, ~y))}
    else({
      p2 = userData() %>% ggvis(~form, ~ratio) %>%
      layer_points(data = userData(), x = ~form, y = ~ratio, fill:="green", fillOpacity := 0.75, fillOpacity.hover := 0.35) %>%
      layer_model_predictions(model = "loess", se = TRUE, stroke:= "green", fill:="green", fillOpacity := 0.5, fillOpacity.hover := 0.15) #%>%
      #add_tooltip(all_values2, "hover")
      
      
      })
    
    merge_ggvis(p1, p2)
    
    }) %>% bind_shiny("ggvis","ggvis_ui")  ### bind it up to shiny
    
    # df1 %>% ggvis(~Xv, ~Yv) %>% 
    #   #### do linear model first so it doesn't block out the hover info for the points
    #   layer_model_predictions(model = "lm", se = TRUE, opacity:=input_radiobuttons(list("On"=.8,"Off"=0),selected = 0,label="View Linear Fit:")) %>% #opacity:= 0.3 )  %>% #, opacity := 0.1, opacity.hover := 0.7, fillOpacity := 0.1, fillOpacity.hover := 0.7) %>%
    #   add_axis("x", title = as.character(Xvar())) %>% add_axis("y", title = as.character(Yvar())) %>%
    #   #### plot the points, with fancy hover aesthetics
    #   layer_points(fill = ~Grouping, key := ~id, fillOpacity := 0.9, fillOpacity.hover := 0.35) %>%
    #   add_legend("fill", title = as.character(grouping())) %>%
    #   #### add the hover information
    #   add_tooltip(all_values, "hover")
    # }) %>% bind_shiny("ggvis","ggvis_ui")  ### bind it up to shiny

  # Print out the results of the linear fit
  # output$showfit <- renderText({
  #     paste(c("Linear Model = ",formulaText())) #}
  # })
  # output$showfit2 <- renderText({
  #     model = lm(as.formula(formulaText()), data=clusts)
  #     paste(c("Slope =",round(model$coefficients[1],2),
  #             ",  Intercept =",round(model$coefficients[2],2),
  #             ", R^2 = ",round(summary(model)$r.squared,2))) #}
  # })
    
    
  ##### Render text that reflects chosen variable
  # output$yvar = renderText({paste(c("Summary of Y-axis variable:", Yvar()))})
  # output$grp = renderText({paste(c("Summary of 'colored-by' variable:", grouping()))})
  # 
  # Return the formula text for printing as a caption at top of screen
  # output$caption <- renderText({formulaText()})
  
})  #end


