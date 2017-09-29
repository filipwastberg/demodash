# Test plot
library(plotly)
fortro %>%
  plot_ly(x = ~date,
          y = ~round(fortro, 2),
          color = ~nedbrytning,
          mode = "lines",
          type = "scatter") %>%
  layout(
    plot_bgcolor = "rgb(250,250,250)",
    font = list(family = "Gill Sans MT"),
    yaxis = list(tickformat = "percent", title = "", range = c(0, 0.5)),
    title = c("Förtroende över tid"),
    titlefont = list(size = 18, family = "Gill Sans MT"),
    showlegend = F)

tabItems(
  # First tab content
  tabItem(tabName = "dashboard",
          fluidRow(
            box(plotOutput("plot1", height = 250)),
            # Boxes need to be put in a row (or column)
            tabItem(
              fluidRow(
                box(selectInput(inputId = "nedbrytning",
                                label = "Välj nedbrytning",
                                choices = unique(fortro$nedbrytning),
                                selected = c("Samtliga"),
                                multiple = TRUE)),
                box(plotlyOutput("plot", height = 250))
              )