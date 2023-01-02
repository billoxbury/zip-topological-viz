library(shiny)
#setwd("~/shiny/zip-1.0")
source("helpers.R")

dat <- read.table("data/zip.fiedler.txt")
x <- zip.train[,-1]
y <- zip.train[,1]
vec <- dat[,1]
fzip <- dat[,-1]

# input <- list(nbins=10, klevel=5, layout="Auto")

shinyServer(

  function(input, output) {
        
    # build clusters:
    cluster.set <- reactive({
      make.clusters(fzip, vec, input$nbins, klevel=input$klevel)
    })
    mg <- reactive({
      mapper.graph(cluster.set())
    })
    comps <- reactive({
      components(mg())
    })
    ncc <- reactive({
      length(comps())
    })
    lout <- reactive({
      lout.fn <- layout.auto
      lout.fn(mg())
    })
    
    # outputs:
    output$graphview <- renderPlot({
      show.graph(mg(), cluster.set(), v=input$obsvertex, layout=lout())
    })
    output$digitview <- renderPlot({
      show.digits(cluster.set(), input$obsvertex)
    })
  }
)
