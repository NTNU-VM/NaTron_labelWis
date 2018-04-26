library(qrencoder)
library(uuid)
library(jsonlite)
library(dplyr)


# Shiny server
function(input, output) {
  
  # select data
  inndata_selected <- reactive({
    a <- inndata %>% filter(recordNumber<=input$recordNumber[2] &
                            recordNumber>=input$recordNumber[1])
    return(a)
  })

  # create tabel for preview of data
  output$table1 <- renderTable(inndata_selected())
  
  # create plot for preview
  output$testlabel <- renderPlot({
    inndata_selected <- inndata_selected()
    QR <- toJSON(inndata_selected[1,]) # data to QR code
    f_QR_only(QR)
    
    
    
  })
  
  # create download of pdf by rendering rmarkdown file
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

