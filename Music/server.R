# Import libraries
library(shiny)
library(ggplot2)
library(viridisLite)
library(ggpubr)

# Define server logic
shinyServer(function(input, output) {

  path <- "C:\\Users\\dmvon\\My Drive\\2021-2022\\S6\\DataVis\\MasQueNada.txt"
  mqn <- read.csv(path, sep = "\t")
  mqn <- mqn %>%
    filter(track %in% c("Vocals", "Strings", "Piano", "Percussion")) %>%
    mutate(Instruments = factor(track, levels = c("Vocals", "Strings", "Piano", "Percussion")))
  
  # Based on select input, remove instrument(s)
  `%notin%` <- Negate(`%in%`)
  mqn_instr <- reactive({mqn %>% 
    filter(track %notin% input$rmv_instr)})

  # Based on radio button input, change plot fill
  scm <- reactive({
    if(input$plot_fill == "default")
      {scale_color_manual(values=c("#000000", "#000000", "#000000", "#000000"))}
    else {
      if(input$plot_fill == "Brazil") 
        {scale_color_manual(values=c("#002776", "#FFDF00", "#009C3B", "#006b3c"))}
      else {
        scale_colour_viridis_d("Instruments")
        }
      }
    })
  
  # Based on numeric input, change point size
  ssm <- reactive({scale_size_manual(values=c(input$point_size,input$point_size,input$point_size,input$point_size))})

  # Scatter & Radial plots 
  output$p1 <- renderPlot({
    mqn_instr() %>% ggplot(aes(x=time, y=note, color=Instruments)) +
      theme_void() + 
      theme(legend.position = c(0.25, 0.85)) + 
      geom_hline(yintercept=34, color="grey", size = 0.5) +
      geom_vline(xintercept=0, color="grey", size = 0.5) +
      geom_segment(aes(x = 0, y = 34, xend = 88888, yend = 34),
                   size = 1.25,
                   color = "black",
                   lineend = "round",
                   linejoin = "round",
                   arrow = arrow(length = unit(0.4, "cm"))) +
      geom_segment(aes(x = 0, y = 34, xend = 0, yend = 70),
                 size = 1.25,
                 color = "black",
                 lineend = "round",
                 linejoin = "round",
                 arrow = arrow(length = unit(0.4, "cm"))) +
      annotate("text", x=44444, y=32, label = "time", size = 3) +
      annotate("text", x=-2500, y=52, label = "note", size = 3, angle = 90) +
      geom_point() +
      scm() +
      ssm() +
      labs(title = paste("Scatter plot"))
  })
  output$p2 <- renderPlot({
    # ggplot(df(), aes(x=x, y=y, color=ctrack)) +
    # geom_point(aes(size=ctrack)) +
    mqn_instr() %>% ggplot(aes(x=x.c, y=y.c, color=Instruments)) +
      theme_void() + 
      theme(legend.position = c(0.1, 0.85)) + 
      scale_x_continuous(limits = c(-75,75)) +
      scale_y_continuous(limits = c(-75,75)) +
      geom_hline(yintercept=0, color="grey", size = 0.5) +
      geom_vline(xintercept=0, color="grey", size = 0.5) +
      geom_segment(aes(x = 0, y = 0, xend = -50, yend = 0),
                   size = 0.75,
                   color = "black",
                   lineend = "round",
                   linejoin = "round",
                   arrow = arrow(length = unit(0.4, "cm"))) +
      geom_curve(aes(x = -8, y = 0, xend = 8, yend = 0),
                 size = 0.75,
                 color = "black",
                 lineend = "round",
                 linejoin = "round",
                 curvature = -1) +
      geom_curve(aes(x = 8, y = 0, xend = -8, yend = 0),
                 size = 0.75,
                 color = "black",
                 lineend = "round",
                 linejoin = "round",
                 curvature = -1,
                 arrow = arrow(length = unit(0.4, "cm"))) +
      annotate("text", x=-25, y=4, label = "note height", size = 3) +
      annotate("text", x=0, y=4, label = "time", size = 3) +
      geom_point() +
      scm() +
      ssm() +
      labs(title = paste("Radial plot"))
    # plot both the scatter and radial plot
  })
  output$p3 <- renderPlot({
  })   
  output$p4 <- renderPlot({
  })   
})