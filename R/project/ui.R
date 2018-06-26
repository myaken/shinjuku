#source('ui_top.R', local = TRUE)
#source('ui_tab_1.R', local = TRUE)
#source('ui_tab_2.R', local = TRUE)
#source('ui_tab_3.R', local = TRUE)
library(ggplot2)

ui <- dashboardPage(
  dashboardHeader(title = "Shiny Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Top", icon=icon("info"), tabName = 'tab_top'
      ),
      menuItem("Perf Analytics", icon=icon("line-chart"), 
               menuSubItem("tab_1", tabName = "tab_1"),
               menuSubItem("tab_2", tabName = "tab_2"),
               menuSubItem("tab_3", tabName = "tab_3"),
               menuSubItem("tab_4", tabName = "tab_4")
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
              tableOutput("contents1"),
              
              
              # Create a new row for the table.
              DT::dataTableOutput("table")
      ),
      tabItem("tab_1",
              h2("tab_1"),
              ### Layout for tab_1 ###
              p("..."),
              verticalLayout(
                tableOutput("contents2")
              )
              
      ),
      tabItem("tab_2",
              h2("tab_2"),
              ### Layout for tab_2 ###
              p("..."),
              tableOutput("contents3")
      ),
      tabItem("tab_3",
              h2("tab_3"),
              ### Layout for tab_3 ###
              p("...") ,
              plotOutput("contents4")
              # plotOutput("contents4")
      ),
      tabItem("tab_4",
              h2("tab_4"),
              ### Layout for tab_4 ###
              p("...") ,
              plotOutput("contents5")
              # plotOutput("contents5")
      )
    )
  ),
  skin="blue"
)