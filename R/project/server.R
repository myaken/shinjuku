library(shiny)
library(ggplot2)

shinyServer(function(input, output) {

  output$contents <- renderTable({
    
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

  output$contents2 <- renderPlot({
    
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
  
  ## Import SumOverTime.R
  .sotfunc.env = new.env()
  sys.source(paste(getwd(),"SumOverTime.R",sep="/"), envir = .sotfunc.env )
  attach( .sotfunc.env )
  
})