library(shiny)

shinyUI(fluidPage(
  
  # suppresses spurious 
  # 'progress' error messages after all the debugging 
  # is done:
  tags$style(type="text/css",
             ".shiny-output-error { visibility: hidden; }",
             ".shiny-output-error:before { visibility: hidden; }"
  ),
  titlePanel("A topological trick for data visualisation"),
  sidebarLayout(
    position = "right",
    sidebarPanel(
      sliderInput("nbins", 
                  label = "Resolution (nr bins):",
                  min = 1, max = 50, value = 10),
      sliderInput("klevel", 
                  label = "Resolution (heirarchical cluster k):",
                  min = 1, max = 20, value = 10),
      numericInput("obsvertex", 
                   label = "Sample vertex:", 
                   value = 1),
      plotOutput("digitview")
      ),
    mainPanel(  
      plotOutput("graphview",
                 height = "800px")
      )
    )
  )
)