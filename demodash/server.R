#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)

server <- function(input, output) {
  output$plot <- renderPlotly({
    fortro %>%
      filter(nedbrytning %in% input$nedbrytning) %>%
      plot_ly(x = ~date,
              y = ~round(fortro, 2),
              color = ~nedbrytning,
              mode = "lines",
              type = "scatter") %>%
      layout(
        plot_bgcolor = "rgb(250,250,250)",
        font = list(family = "Gill Sans"),
        yaxis = list(tickformat = "%", title = "", range = c(0, 0.5)),
        xaxis = list(title = ""),
        titlefont = list(size = 26, family = "Gill Sans"),
        showlegend = F,
        annotations = list(x = "2017-01-01", y = 0.5,
                           xanchor = "left",
                           yanchor = "top",
                           text = paste0("<b>Kännedom över tid</b>"),
                           showarrow = FALSE,
                           font = list(size = 30,
                                       family = "Gill Sans")))
  })
  output$plot_mlt <- renderPlotly({
  mltwater %>%
    plot_ly(x = ~date,
            y = ~Antal,
            color = ~typ,
            mode = "lines",
            type = "scatter") %>%
    layout(
      plot_bgcolor = "rgb(250,250,250)",
      font = list(family = "Gill Sans"),
      yaxis = list(title = "", range = c(0, 27943924)),
      xaxis = list(title = ""),
      titlefont = list(size = 26, family = "Gill Sans"),
      showlegend = F,
      annotations = list(x = "2017-08-01", y = 27943924,
                         xanchor = "left",
                         yanchor = "top",
                         text = paste0("<b>Resia i medier</b>"),
                         showarrow = FALSE,
                         font = list(size = 30,
                                     family = "Gill Sans")))
  })
  output$progressBox <- renderValueBox({
    valueBox(
      paste0(25000), "RM", icon = icon("list"),
      color = "purple"
    )
  })
  
  output$approvalBox <- renderValueBox({
    valueBox(paste0(41, "%"), "Kännedom",
             icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow"
    )
  })
}
