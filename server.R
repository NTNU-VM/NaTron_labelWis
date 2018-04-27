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
    if (input$label_template=="QR + text"){
      inndata_selected <- inndata_selected()
      QRcode <- toJSON(inndata_selected[1,]) # data to QR code
      textSize <- input$textsize
      prst_s1 <- paste("recordNumber:",inndata_selected$recordNumber[1])
      prst_s2 <- paste("catalogNumber:",inndata_selected$catalogNumber[1])
      prst_s3 <- paste("scientificName:",inndata_selected$scientificName[1])
      prst_s4 <- paste("collectionCode:",inndata_selected$collectionCode[1])
      f_plot_label(QRcode,textSize,prst_s1,prst_s2,prst_s3,prst_s4) 
    }
    if (input$label_template=="QR only"){
      inndata_selected <- inndata_selected()
      QRcode <- toJSON(inndata_selected[1,]) # data to QR code
      textSize <- input$textsize
      prst_s1 <- paste("recordNumber:",inndata_selected$recordNumber[1])
      prst_s2 <- paste("catalogNumber:",inndata_selected$catalogNumber[1])
      prst_s3 <- paste("scientificName:",inndata_selected$scientificName[1])
      prst_s4 <- paste("collectionCode:",inndata_selected$collectionCode[1])
      f_plot_label(QRcode,textSize)#,prst_s1,prst_s2,prst_s3,prst_s4) 
    }

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

