library(shiny)
library(ggplot2)
library(anytime)
library(Cairo)
library(DT)
library(shinydashboard)
library(stringr)
library(lubridate)
library(maptools)

shinyServer(function(input, output) {

  output$contents1 <- DT::renderDataTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)

        data <- df
        DT::datatable(data,
                      rownames = FALSE,
                      class = "cell-border stripe",
                      extensions = 'Buttons', 
                      options = list(searching = FALSE,
                                    dom = 'Bfrtip', buttons = I('colvis'),
                                    initComplete = JS(
                                      "function(settings, json) {",
                                      "$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});",
                                      "}")
                                    )
                      )
        
#        data
  })  

  output$contents2 <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)
    
    if(input$disp == "head") {
    }
    else {
        plot(x = rnorm(df), y = rnorm(df))
    }
    
  })
  
  ## Import DataCompilation.R
  .dcfunc.env = new.env()
  sys.source(paste(getwd(),"DataCompilation.R",sep="/"), envir = .dcfunc.env )
  attach( .dcfunc.env )

  ## Import DailyScatterPlot.R
  .dsfunc.env = new.env()
  sys.source(paste(getwd(),"DailyScatterPlot.R",sep="/"), envir = .dsfunc.env )
  attach( .dsfunc.env )
  
  ## Import MonthlyScatterPlot.R
  .msfunc.env = new.env()
  sys.source(paste(getwd(),"MonthlyScatterPlot.R",sep="/"), envir = .msfunc.env )
  attach( .msfunc.env )
})