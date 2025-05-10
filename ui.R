library(shiny)

ui <- fluidPage(
      
      #title
      titlePanel("Plot expression in TPMs of chosen gene"),
      
      sidebarLayout(
          #bar in which we choose gene
          sidebarPanel(
            selectInput(
              "genes",
              "Choose gene:",
              choices = NULL
            )
          ),
          mainPanel(
              #output: row and plot of chosen gene
              tableOutput("gene_data"),
              plotOutput("gene_plot")
          )
      )
)
  
