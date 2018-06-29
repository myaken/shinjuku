ranges <- reactiveValues(x = NULL, y = NULL)

output$contents6 <- renderPlot({
  
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
  MonthLabel <- NA
  MonthOverTime <- NA
  labeldt <- NA
  
  while(length(OverTime) >= i) {
    
    labeldate <- as.Date(strDate[i])
    for (j in 1:length(labeldate)){
      month(labeldate[j]) <- month(labeldate[j]) + 1
    }
    
    monthdate <- NA
    for (n in 1:length(labeldate)){
      monthdate[n] <- as.character(labeldate[n])
      monthdate[n] <- str_sub(monthdate[n], start = 1, end = 7)
      MonthLabel[k] <- str_replace_all(monthdate[n], "-", "")
    }
    
    
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
    labeldt[k] <- as.character(JetNo[i])
    k <- k + 1
    
  }
  
  newdt <- data.frame(
    JetNo,
    FullName,
    strDate,
    Calendar,
    OverTime,
    NightWork
  )
  
  x <- MonthLabel
  y <- MonthOverTime

  row <- as.Date(paste(MonthLabel, "01"), format="%Y%m%d")
  
   plot(row, y, xlab="date(x)", ylab="time(y)", col="blue", las=1, xaxt="n")
   #geom_text(aes(y=y+0.2))
   name = c(x)
   # axis(1,row,labels=name)
   # for (i in 1:length(labeldt)) {
   #   pointLabel(row, y, labels=labeldt[i])
   # }
   pointLabel(row, y, labels=labeldt)
   abline(h=80, col="orange")
   abline(h=100, col="red")
      
 })