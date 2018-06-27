ranges <- reactiveValues(x = NULL, y = NULL)

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
  
  x <- Date
  y <- OverTime
  # print()
  #plot(x, y, cex=0.5, pch=4, xlab="date(x)", ylab="hours(y)", col="blue", ylim=C(0.000, 10.000))
  #plot(x, y, cex=0.5, pch=4, xlab="date(x)", ylab="hours(y)", col="blue")
  ggplot(newdt, aes(x, y)) +
    geom_point() +
    coord_cartesian(xlim = ranges$x, ylim = ranges$y, expand = FALSE)
  
})

# When a double-click happens, check if there's a brush on the plot.
# If so, zoom to the brush bounds; if not, reset the zoom.
observeEvent(input$plot1_dblclick, {
  brush <- input$plot1_brush
  if (!is.null(brush)) {
    print(brush$xmin)
    print(brush$ymin) 
    
    # print()
    ranges$x <- c(as.Date(brush$xmin, origin = "1970-01-01"), as.Date(brush$xmax, origin = "1970-01-01"))
    ranges$y <- c(brush$ymin, brush$ymax)
    
  } else {
    ranges$x <- NULL
    ranges$y <- NULL
  }
})