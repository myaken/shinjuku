<<<<<<< HEAD
=======
# push‚É•s—vƒtƒ@ƒCƒ‹‚ğœŠO‚·‚é•û–@ŒŸ“¢

>>>>>>> parent of 44f2c6a... PULLReqæ™‚ã«ä¸è¦ãƒ•ã‚¡ã‚¤ãƒ«ã‚’é™¤å¤–ã™ã‚‹æ–¹æ³•æ¤œè¨
library(shiny)

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
})