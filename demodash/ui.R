#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(plotly)

dbHeader <- dashboardHeader(title = "Resia Dashboard",
                            titleWidth = 250,
                            tags$li(a(href = 'https://www.demoskop.se',
                                      img(src = 'logga.png',
                                          title = "Company Home", height = "30px"),
                                      style = "padding-top:10px; padding-bottom:10px;"),
                                    class = "dropdown"))

dashboardPage(skin = "yellow",
  dbHeader,
  dashboardSidebar(
    sidebarMenu(
      sidebarSearchForm(textId = "searchText", buttonId = "searchButton",
                        label = "Sök..."),
      menuItem("Kännedom över tid", tabName = "kannedom-tid", icon = icon("dashboard")),
      menuItem("Resia i medier", tabName = "medier", icon = icon("cloud"))
    )
  ),  dashboardBody(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    tags$body(
    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    tabItems(
      # First tab content
      tabItem(tabName = "kannedom-tid",
              h2("Kännedom om Resia"),
              p("Den här sidan redovisar kännedom om Resia över tid.
                Kännedom mäts löpande med 100 intervjuer per vecka.
                Urvalet är allmänheten 18 år+. Resultatet är vägt på kön och ålder."),
              fluidRow(
                valueBox(10 * 2, "Försäljningskvot", icon = icon("credit-card")),
                # Dynamic valueBoxes
                valueBoxOutput("progressBox"),
                valueBoxOutput("approvalBox"),
                box(status = "warning",
                    selectInput(inputId = "nedbrytning",
                                label = "Välj nedbrytning",
                                choices = unique(fortro$nedbrytning),
                                selected = c("Samtliga"),
                                multiple = TRUE),
                    width = 2,
                    height = 200),
                box(status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    width = 10,
                    plotlyOutput("plot"),
                    height = 500)
                )
              )
      ,
      
      # Second tab content
      tabItem(tabName = "medier",
              h2("Resia i nyheter och sociala medier"),
              p("Den här sidan redovisar via omvärldsbevakningsverktyget Meltwater
                antalet personer som nåtts via artiklar eller sociala medier som
                har nämnt Resia. Under slutet av augusti nåddes hela 25 miljoner."),
              fluidRow(
                box(status = "primary",
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    width = 10,
                    plotlyOutput("plot_mlt"),
                    height = 500)
              ),
              p("Observera att detta är faktisk data från Meltwaters API")
              
      )
    )
  )
)
