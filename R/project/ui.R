#source('ui_top.R', local = TRUE)
#source('ui_tab_1.R', local = TRUE)
#source('ui_tab_2.R', local = TRUE)
#source('ui_tab_3.R', local = TRUE)
library(ggplot2)

ui <- dashboardPage(
  dashboardHeader(title = "R challenge"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Top", icon=icon("info"), tabName = 'tab_top'
      ),
      menuItem("Perf Analytics", icon=icon("line-chart"), 
               menuSubItem("ScatterPlot(daily)", tabName = 'tab_1'),
               menuSubItem("ScatterPlot(Monthly)", tabName = 'tab_2')
      ),
      fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      # Input: Checkbox if file has header ----
      checkboxInput("header", "Header", TRUE),
      
      # Input: Select separator ----
      radioButtons("sep", "Separator",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),
      
      # Input: Select quotes ----
      radioButtons("quote", "Quote",
                   choices = c(None = "",
                               "Double Quote" = '"',
                               "Single Quote" = "'"),
                   selected = '"'),
      
      # Horizontal line ----
      tags$hr(),
      
      # Input: Select number of rows to display ----
      radioButtons("disp", "Display",
                   choices = c(Head = "head",
                               All = "all"),
                   selected = "head")
    )

#    # Main panel for displaying outputs ----
#    mainPanel(
#      
#      # Output: Data file ----
#      tableOutput("contents")
#      
#    )
    
  ),
#  dashboardBody(
#    tabItems(
#      tabItem_Info,
#      
#      tabItem_CPU,
#      tabItem_Memory,
#      tabItem_Disk
#      
#    )
#  ),

  dashboardBody(
    tabItems(
      tabItem("tab_top",
              h2("Information"),
              #              div(img(src="bigorb.png"),align="center"),
              # Create a new row for the table.
              helpText("Please choose CSV file."),
              DT::dataTableOutput("contents1")
      ),
      tabItem("tab_1",
            h2("ScatterPlot(daily)"),
            ### Layout for tab_1 ###
            p("...") ,
            # plotOutput("contents5"),
            #h4("Brush and double-click to zoom"),
            plotOutput("contents5",
                       dblclick = "plot1_dblclick",
                       brush = brushOpts(
                         id = "plot1_brush",
                         resetOnNew = TRUE
                       ),
                       hover = hoverOpts("plot_hover", delay = 100, delayType = "debounce")
            )
      ),
      tabItem("tab_2",
            h2("ScatterPlot(Monthly)"),
            ### Layout for tab_2 ###
            p("...") ,
            plotOutput("contents6")
      )
    )
  ),
  skin="blue"
)