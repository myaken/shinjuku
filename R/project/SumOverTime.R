output$contents4 <- renderTable({
  
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
  i <- 1
  j <- 1
  k <- 1
  MonthOverTime <- NA
  while(length(OverTime) >= i) {
    if(str_detect(strDate[i], "16$")) {
      tmp <- OverTime[i]
      i <- i + 1
    } else {
      tmp <- 0.00
    }
    
    while(!str_detect(strDate[i], "16$") & length(OverTime) >= i) {
      tmp <- OverTime[i] + tmp
      i <- i + 1
    }
    
    i <- i + 1
    MonthOverTime[k] <-tmp
    k <- k + 1
  }
  
  print(MonthOverTime)
  
  newdt <- data.frame(
    JetNo,
    FullName,
    strDate,
    Calendar,
    OverTime,
    NightWork
  )
  
  print(newdt)
  
})