#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Problem1: Shiny app for NLP"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       
       fileInput("text_file", label = "Upload text file:"),
       fileInput("udpipe_file", label = "Upload trained udpipe model:"),
       checkboxGroupInput("pos_tags", label = "Select list of part-of-speech tags (XPOS):", 
                          choices = list("adjective (JJ)" = 1, "noun (NN)" = 2, "proper noun (NNP)" = 3,
                                         "adverb (RB)" = 4, "verb (VB)" = 5),
                          selected = list(1,2,3))
       
    ),   # end of sidebar panel
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  
                  tabPanel("Overview",
                           h4('How to use this App?'),
                           p('To use this app, first click on', 
                             span(strong("Upload text file:")),
                             'and upload the input text file.'),
                           p('Then you may need to upload the trained udpipe model of any required language by clicking on',
                             span(strong("Upload trained udpipe model:"))),
                           p('You can also select the part-of-speech tags from the given list of checkboxes')),

                  tabPanel("Cluster mean",
                           tableOutput('clust_summary')),
                  
                  tabPanel("Data",
                           dataTableOutput('clust_data'))
                  
      ) # end of tabsetPanel
    )
  )
))
