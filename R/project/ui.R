<<<<<<< HEAD
#source('ui_top.R', local = TRUE)
#source('ui_tab_1.R', local = TRUE)
#source('ui_tab_2.R', local = TRUE)
#source('ui_tab_3.R', local = TRUE)

ui <- dashboardPage(
  dashboardHeader(title = "Shiny Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Top", icon=icon("info"), tabName = 'tab_top'
      ),
      menuItem("Perf Analytics", icon=icon("line-chart"), 
               menuSubItem("tab_1", tabName = "tab_1"),
               menuSubItem("tab_2", tabName = "tab_2"),
               menuSubItem("tab_3", tabName = "tab_3")
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
              tableOutput("contents")
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
              p("...")
      ),
      tabItem("tab_3",
              h2("tab_3"),
              ### Layout for tab_3 ###
              p("...") 

      )
    )
  ),
  skin="blue"
=======
source('ui_Info.R', local = TRUE)
source('ui_CPU.R', local = TRUE)
source('ui_Memory.R', local = TRUE)
source('ui_Disk.R', local = TRUE)
source('ui_MachineList.R', local = TRUE)
source('ui_Config.R', local = TRUE)

ui <- dashboardPage(
  dashboardHeader(title = "Shiny Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Information", icon=icon("info"), tabName = 'tab_Info'
      ),
      menuItem("Perf Analytics", icon=icon("line-chart"), 
               menuSubItem("CPU", tabName = "tab_CPU"),
               menuSubItem("Memory", tabName = "tab_Memory"),
               menuSubItem("Disk", tabName = "tab_Disk")),
      menuItem("Admin", icon=icon("gear"),
               menuSubItem("MachineList", tabName = "tab_MachineList"),
               menuSubItem("Config", tabName = "tab_Config")
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
#      tabItem_Disk,
#      
#      tabItem_MachineList,
#      tabItem_Config
#      
#    )
#  ),


  dashboardBody(
    tabItems(
      tabItem("tab_Info",
              h2("Information"),
              div(img(src="bigorb.png"),align="center"),
              tableOutput("contents")
      ),
      tabItem("tab_CPU",
              h2("CPU Usage"),
              ### Layout for CPU tab ###
              p("..."),
              verticalLayout(
                tableOutput("contents2")
              )

      ),

      tabItem("tab_Memory",
              h2("Memory Usage"),
              ### Layout for Memory tab ###
              p("...")

      ),
      tabItem("tab_Disk",
              h2("Disk Usage"),
              ### Layout for Disk tab ###
              p("...") 

      ),
      tabItem("tab_MachineList",
              h2("MachineList"),
              ### Layout for MachineList tab ###
              p("...")

      ),
      tabItem("tab_Config",
              h2("Config"),
              ### Layout for Config tab ###
              p("...")

      )
    )
  ),


  skin="blue"
>>>>>>> e6f70fa3441e6717eb7f5953738abccdc76d345c
)