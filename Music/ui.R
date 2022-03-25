# Import the library
library(shiny)
library(tidyverse)

# Application Layout
shinyUI(
  fluidPage(
    titlePanel(title = "Music Data Visualizations by Dimitri von Benckendorff"),
    sidebarLayout(
      sidebarPanel(
        h4("Welcome to this data visualization project dedicated to my loving mother."),
        h4("Inspired by Priya Padham (Tableau), I decided to visualize the instruments in Mas Que Nada by Sergio Mendes and The Black Eyed Peas."),
        br(),
        h4("Which instrument groups should (not) be displayed?"),
        selectInput("rmv_instr",
                    "Remove instrument(s):",
                    choices = c("Vocals" = "Vocals", "Strings" = "Strings", "Piano" = "Piano", "Percussion" = "Percussion"),
                    selected = NULL,
                    multiple = TRUE),
        br(),
        h4("What should the plot look like?"),
        radioButtons("plot_fill", 
                    "Plot fill:", 
                    choices = c("default", "color-blind", "Brazil"),
                    selected = "Brazil"),
        sliderInput("point_size",
                    "Point size:",
                    value = 2.00,
                    min = 0.5,
                    max = 2.8)
      ),
      mainPanel(
        tabsetPanel(
          tabPanel(
            h4("Exploring Mas Que Nada"),
            plotOutput("p1", height = 333), # scatter plot
            plotOutput("p2") # radial plot
          ),
          tabPanel(
            h4("Exploring It Ain't Me"),
            plotOutput("p3"),  # scatter plot
            plotOutput("p4")   # radial plot
          ),  
        ), position = "right"
      )
    )
  )
)