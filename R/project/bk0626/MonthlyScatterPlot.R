output$contents5 <- renderPlot({
  
  req(input$file1)
  
  dt <- read.csv(input$file1$datapath,
                 header = input$header,
                 sep = input$sep)
  
  JetNo <- dt[,1]
  FullName <- dt[,2]
  Date <- dt[,5]
  Calendar <- dt[,7]
  
  Date <- as.Date(dt[,5], "%Y/%m/%d")
  strDate <- as.character(Date)
  
  for (i in 1:length(strDate)) {
    strDate[i] <- str_replace_all(strDate[i], "-", "/")
  }
  
  jikan <- as.POSIXlt(dt[,18], format="%H:%M")
  hours <- jikan$hour + jikan$min / 60
  hours[is.na(hours)] <- 0.00
  
  for (i in 1:length(hours)) {
    hours[i] <- round(hours[i], digits = 3)
  }
  
  
  night <- as.POSIXlt(dt[,21], format="%H:%M")
  nighthours <- night$hour + night$min / 60
  nighthours[is.na(nighthours)] <- 0.00
  
  for (i in 1:length(nighthours)) {
    nighthours[i] <- round(nighthours[i], digits = 3)
  }
  
  
  OverTime <- hours
  NightWork <- nighthours
  newdt <- data.frame(
    JetNo,
    FullName,
    strDate,
    Calendar,
    OverTime,
    NightWork
  )
  
  ## 月ごとのデータに加工
  Month <- split()
  for (i in 1:length(Date)) {
    tmpMonth <- 
    
    if( grep("/15$",Date[i]) ){
      Month <- append("")
      MonthlyOverTime <- append("")
    }
    
  }

    
  
  x <- Month
  y <- OverTime
  # print()
  plot(x, y, cex=0.5, pch=4, xlab="日付(x)", ylab="残業時間(y)", col="blue")
  

})