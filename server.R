library(qrencoder)
library(uuid)
library(jsonlite)
library(dplyr)


# Shiny server
function(input, output) {
  
  output$selected_var <- renderText({ input$recordNumber })
  
  inndata_selected <- reactive({
    a <- inndata %>% filter(recordNumber<=input$recordNumber[2] &
                            recordNumber>=input$recordNumber[1])
    return(a)
  })
  
  output$table1 <- renderTable(inndata_selected())
  
  output$testlabel <- renderPlot({
    inndata_selected <- inndata_selected()
      inputString <- toJSON(inndata_selected[1,])
      printString_l1 <- paste("occurrenceID:",inndata_selected$occurrenceID[1])
      printString_l2 <- paste("recordNumber:",inndata_selected$recordNumber[1])
      par(mar=c(4,4,4,4))
      image(qrencode_raster(inputString), 
            asp=1, col=c("white", "black"), axes=FALSE, 
            xlab="", ylab="",bty="l")
      mtext(printString_l1,side=1,line = 1,cex=input$textsize)
      mtext(printString_l2,side=1,line = 2,cex=input$textsize)
      box(which = "outer", lty = "solid")
  })
  
  output$labels <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = "labels.pdf",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempLabels <- file.path(tempdir(), "labels.Rmd")
      file.copy("labels.Rmd", tempLabels, overwrite = TRUE)
      
      # Set up parameters to pass to Rmd document
      #params <- list(n = input$slider)
      
      # Knit the document, passing in the `params` list, and eval it in a
      # child of the global environment (this isolates the code in the document
      # from the code in this app).
      rmarkdown::render(tempLabels, output_file = file#,
                        #params = params,
                        #envir = new.env(parent = globalenv())
      )
    }
  )
  
}

