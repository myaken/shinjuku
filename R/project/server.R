library(shiny)
library(ggplot2)

shinyServer(function(input, output) {

  output$contents1 <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)
    
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
    
    # Filter data based on selections #########TEST##########
    output$table <- DT::renderDataTable(DT::datatable({
      if(input$disp != "head") {
        data <- df
        data
      }
    }))
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
  .dcfunc.env2 = new.env()
  sys.source(paste(getwd(),"DailyScatterPlot.R",sep="/"), envir = .dcfunc.env2 )
  attach( .dcfunc.env )
  
  ## Import MonthlyScatterPlot.R
  .dcfunc.env3 = new.env()
  sys.source(paste(getwd(),"MonthlyScatterPlot.R",sep="/"), envir = .dcfunc.env3 )
  attach( .dcfunc.env )

})

