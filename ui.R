# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Problem1: Shiny app using UDPipe NLP Workflow"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       
       fileInput("text_file", label = "Upload text file:"),
       radioButtons("lang", label = "Select the language of the text uploaded:",
                    choices = list("English" = 1, "Hindi" = 2, "Spanish" = 3), 
                    selected = 1),
       hr(),
       fluidRow(column(3, verbatimTextOutput("value"))),
       fileInput("udpipe_file", label = "Upload trained udpipe model of the selected language:"),
       checkboxGroupInput("pos_tags", label = "Select list of part-of-speech tags :", 
                          choices = list("adjective (JJ)" = 1, "noun (NN)" = 2, "proper noun (NNP)" = 3,
                                         "adverb (RB)" = 4, "verb (VB)" = 5),
                          selected = list(1,2,3))
       # checkboxGroupInput("pos_tags", label = "Select list of part-of-speech tags :", 
       #                    choices = list("adjective (JJ)" = 'JJ', "noun (NN)" = 'NN', "proper noun (NNP)" = 'NNP',
       #                                   "adverb (RB)" = 'RB', "verb (VB)" = 'VB'),
       #                    selected = list('JJ','NN','NNP'))
       
    ),   # end of sidebar panel
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type = "tabs",
                  
                  tabPanel("Overview",
                           h4('How to use this App?'),
                           p('To use this app, first click on', span(strong("Upload text file:")),
                             'and upload the input text file.'),
                           p('Now specify the language of the text file uploaded, by using the list provided under', 
                             span(strong("Select the language of the text uploaded:"))),
                           p('Then you need to upload the trained udpipe model of the specified language by clicking on',
                             span(strong("Upload trained udpipe model of the selected language:"))),
                           p('You can also select the part-of-speech tags from the given list of checkboxes')),

                  #tabPanel("Wordcloud",plotOutput("wordcloud",height = 700, width = 700)),
                  tabPanel("data",verbatimTextOutput("dataset")),
                  
                  tabPanel("Co-occurrence",plotOutput("coocrplots"))
                  
      ) # end of tabsetPanel
    )
  )
))
