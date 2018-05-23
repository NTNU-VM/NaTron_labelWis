library(qrencoder)
library(uuid)
library(jsonlite)
library(dplyr)


# Shiny server
function(input, output) {
  
  # create tabel for preview of data
  #output$table1 <- renderTable(inndata_selected())
  output$labelDataTable <- DT::renderDataTable(#inndata_selected(),
    inndata,
    filter = "top",
    selection = list(target = 'row+column'))
  
  # inndata selected is selected rows in datatable
  inndata_selected <- reactive({
    s <-
      input$labelDataTable_rows_all # rows selected from datatable (NB: "labelDataTable" is the dataTabel ID)
    a <- as.data.frame(inndata[s, ])
    names(a) <- names(inndata)
    return(a)
  })
  


  # QR code content
  qrcode_content <- reactive({
    inndata_selected <- inndata_selected()
    qrcode_content <- inndata_selected %>% select(input$QRcontent)
    return(qrcode_content)
  })
  
  output$qrcode_content_example <- renderText({
    qrcode_content_example <- qrcode_content()
    json_out <- qrcode_content_example %>% filter(row_number()==1)
    json_out <- toJSON(json_out)
    return(json_out)
  })
  
  
  # Create image of label for preview
  output$labelImage <- renderImage({
    # input parameters and data to QR-code
    QRcode_data <- qrcode_content()
    QRcode_data <- QRcode_data %>% filter(row_number()==1)
    QRcode <- toJSON(QRcode_data)
    textSize <- input$textsize
    marg1 <- input$labelMargin
    line_prst_s1 <- input$bottom_text_line
    
    # input to label text
    inndata_selected <- inndata_selected()
    
    if(input$bottom_text==""){
      prst_s1 <- ""
    } else {
      prst_s1_data <- inndata_selected %>% 
        select(input$bottom_text) %>%
        filter(row_number()==1)
      prst_s1 <- paste0(names(prst_s1_data), ": ", prst_s1_data[1,])
    }

    if(input$left_side_text==""){
      prst_s2 <- ""
    } else {
    prst_s2_data <- inndata_selected %>% 
      select(input$left_side_text) %>%
      filter(row_number()==1)
    prst_s2 <- paste0(names(prst_s2_data), ": ", prst_s2_data[1,])
    }
    
    if(input$top_text==""){
      prst_s3 <- ""
    } else {
    prst_s3_data <- inndata_selected %>% 
      select(input$top_text) %>%
      filter(row_number()==1)
    prst_s3 <- paste0(names(prst_s3_data), ": ", prst_s3_data[1,])
    }
    
    if(input$rigth_side_text==""){
      prst_s4 <- ""
    } else {
    prst_s4_data <- inndata_selected %>% 
      select(input$rigth_side_text) %>%
      filter(row_number()==1)
    prst_s4 <- paste0(names(prst_s4_data), ": ", prst_s4_data[1,])
    }

    
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext = '.jpeg')
    
    # Generate the jpeg
    jpeg(
      filename = outfile,
      width = input$labelWidth,
      height = input$labelHeigth,
      units = "mm",
      pointsize = 8,
      quality = 75,
      res = 150,
      bg = "white"
    )
    
    # Plot label by running function defined in the "function.R" file
      f_plot_label(QRcode,
                   textSize,
                   marg1,
                   prst_s1,
                   line_prst_s1,
                   prst_s2,
                   prst_s3,
                   prst_s4)
   dev.off()
    
    # Return a list containing the filename
    list(src = outfile,
         contentType = 'image/jpeg',
         alt = "Label preview")
    
  }, deleteFile = TRUE) # delete output file after sending data
  
  # create download of pdf by rendering rmarkdown file
  output$labels_pdf <- downloadHandler(
    # For PDF output, change this to "report.pdf"
    filename = "labels.pdf",
    content = function(file) {
      # Copy the report file to a temporary directory before processing it, in
      # case we don't have write permissions to the current working dir (which
      # can happen when deployed).
      tempLabels <- file.path(tempdir(), "labels.Rmd")
      file.copy("labels.Rmd", tempLabels, overwrite = TRUE)
      
      # Knit the document
      rmarkdown::render(tempLabels, output_file = file)
    }
  )
  # clean up cache on exit
  on.exit(file.remove(list.files(
    tempdir(), pattern = ".jpeg", full.names = TRUE
  )))
  
  
  

}

