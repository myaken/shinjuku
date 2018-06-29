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
  labeldt <- data.frame(
    JetNo
  )
  x <- Date
  y <- OverTime
  # print()
  #plot(x, y, cex=0.5, pch=4, xlab="date(x)", ylab="hours(y)", col="blue", ylim=C(0.000, 10.000))
  #plot(x, y, cex=0.5, pch=4, xlab="date(x)", ylab="hours(y)", col="blue")
  # newdt$tooltip <- paste0( "test<br/>", newdt[, 1])
  # newdt$click <- paste0("function() {alert('test", newdt[, 2],
  #                          " test", newdt[, 3]," end')}" )
  
  ggplot(newdt, aes(x, y, label=labeldt)) +
    geom_point(alpha = (1/3), size = 3) +
    geom_text(aes(y=y+0.2)) +
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

# output$hover_info <- renderUI({
#   hover <- input$plot_hover
#   point <- nearPoints(sub(), hover, threshold = 5, maxpoints = 1, addDist = TRUE)
#   
#   if (nrow(point) == 0) return(NULL)
#   
#   left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
#   top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
#   
#   left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
#   top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
#   
#   style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
#                   "left:", left_px + 2, "px; top:", top_px + 2, "px;")
#   
#   wellPanel(
#     style = style,
#     p(HTML(paste0("<b>", point$variable, ": </b>", point$value)))
#   )
# })