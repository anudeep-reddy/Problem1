#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

options(shiny.maxRequestSize=30*1024^2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  dataset <- reactive({
    if (is.null(input$text_file)) {return(NULL)}
    else {
      doc = readLines(input$text_file$datapath)
      #require(stringr)
      #doc  =  str_replace_all(doc,"\s\s+", "") #extra spaces condensed into 1
      #doc  =  str_replace_all(doc,"^\sa-zA-Z0-9.-","")  #remove special characters
      return(doc)}
    })
  
  output$pos_vector<-reactive({
    
    pos.vector <- as.vector(input$pos_tags)
    return(pos.vector)
    
    })
  
    
   annote_txt<-reactive({
     
     model = udpipe_load_model(input$udpipe_file$datapath)  # Load the model uploaded
     
     # now annotate text dataset using ud_model above
     # system.time({   # ~ depends on corpus size
     x <- udpipe_annotate(model, x = doc) #%>% as.data.frame() %>% head()
     x <- as.data.frame(x)
     x<-as.data.frame(x)
      return(x)
     
    })
  
  doc_cooc<-reactive({
    cooc_txt <- cooccurrence(   
      x = subset(x, upos %in% pos.vector), 
      term = "lemma", 
      group = c("doc_id", "paragraph_id", "sentence_id"))
    
    
    })
  
  output$coocrplots <- renderUI({
    if (is.null(input$file)) {return(NULL)}
    else {
      
      plot_output_list <- lapply(1:input$seg, function(i) {
        plotname <- paste("plot1", i, sep="")
        plotOutput(plotname, height = 700, width = 700)
      })
      # Convert the list to a tagList - this is necessary for the list of items
      # to display properly.
      do.call(tagList, plot_output_list)
    }
    })
   
  })

