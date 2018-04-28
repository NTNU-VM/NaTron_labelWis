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

  # Create image of label for preview
    output$labelImage <- renderImage({
    inndata_selected <- inndata_selected()
    inndata_to_QR <- inndata_selected %>% select(materialSampleID)
    QRcode <- toJSON(data.frame(materialSampleID=inndata_to_QR[1,])) # data to QR code
    textSize <- input$textsize
    prst_s1 <- paste("recordNumber:",inndata_selected$recordNumber[1])
    prst_s2 <- paste("catalogNumber:",inndata_selected$catalogNumber[1])
    prst_s3 <- paste("scientificName:",inndata_selected$scientificName[1])
    prst_s4 <- paste("collectionCode:",inndata_selected$collectionCode[1])
      
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext = '.jpeg')
      
    # Generate the jpeg
    jpeg(filename = outfile,
          width = input$labelWidth, height = input$labelHeigth, units = "mm", pointsize = 8,
          quality = 75,res=150,
          bg = "white")
    
    # choose label text according to label_template imput from UI
    if (input$label_template=="QR only"){
      f_plot_label(QRcode,textSize) 
    }
    if (input$label_template=="QR + text"){
      f_plot_label(QRcode,textSize,prst_s1,prst_s2,prst_s3,prst_s4) 
    }
    if (input$label_template=="QR + catalogNumber & collectionCode"){
      f_plot_label(QRcode,textSize,prst_s2,prst_s4) 
    }
    dev.off()
      
    # Return a list containing the filename
    list(src = outfile,
          contentType = 'image/jpeg',
          alt = "Label preview")
  
  }, deleteFile = TRUE) # delete output file after sending data

  # create tabel for preview of data
  #output$table1 <- renderTable(inndata_selected())
  output$labelDataTable <- DT::renderDataTable(
    inndata_selected(), 
    filter = "top"
  )
  
  
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

      # Knit the document
      rmarkdown::render(tempLabels, output_file = file
      )
    }
  )
  
}

