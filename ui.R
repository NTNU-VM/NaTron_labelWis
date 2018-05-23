
source("dataIO.R")
source("functions.R")

# UI
fluidPage(
  titlePanel("Tabsets"),
  sidebarLayout(
    sidebarPanel(
      h3("Preview of label"),
      imageOutput("labelImage"),
      a(
        "View code and technical documentation at GitHub",
        href = "https://github.com/NTNU-VM/NaTron_labelWis",
        target = "_blank"
      ),
      br(),
      br(),
      downloadButton('labels_pdf',label = "Download QR")
    ),
    mainPanel(
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabsetPanel(type = "tabs",
                              
                              # Tab filter input data
                              tabPanel("Filter input data", 
                                       h3("Preview and select input data for labels"),
                                       p(
                                         "Select records for printing to labels. Subset table by using the boxes above columns, or the 'search' field"
                                       ),
                                       DT::dataTableOutput("labelDataTable")
                              ),
                              
                              # Tab basic layout
                              tabPanel("Basic layout", 
                                       sliderInput(
                                         "labelWidth",
                                         label = "Choose labels width:",
                                         min = 10,
                                         max = 150,
                                         value = 60
                                       ),
                                       sliderInput(
                                         "labelHeigth",
                                         label = "Choose labels heigth:",
                                         min = 10,
                                         max = 150,
                                         value = 60
                                       ),
                                       sliderInput(
                                         "labelMargin",
                                         label = "Choose labels margin:",
                                         min = 0.5,
                                         max = 6,
                                         value = 4,
                                         step = 0.5
                                       ),
                                       sliderInput(
                                         "textsize",
                                         label = "Choose text size:",
                                         min = 0,
                                         max = 4,
                                         value = 1,
                                         step = 0.05
                                       ),
                                       h3("Select and adjust label text"),
                                       selectInput(
                                         'bottom_text',
                                         'Choose bottom text:',
                                         choices = c("", names(inndata))
                                       ),
                                       sliderInput(
                                         "bottom_text_line",
                                         label = "Choose bottom text line position:",
                                         min = 0, max = 4, value = 1, step = 0.01),
                                       selectInput(
                                         'left_side_text',
                                         'Choose left side text:',
                                         choices = c("", names(inndata))
                                       ),
                                       selectInput(
                                         'rigth_side_text',
                                         'Choose rigth side text:',
                                         choices = c("", names(inndata))
                                       ),
                                       selectInput(
                                         'top_text',
                                         'Choose top text:',
                                         choices = c("", names(inndata))
                                       ),
                                       downloadButton('labels'),
                                       br(),
                                       br(),
                                       a(
                                         "View code and technical documentation at GitHub",
                                         href = "https://github.com/NTNU-VM/NaTron_labelWis",
                                         target = "_blank"
                                       )
                                       
                                       
                                       
                                       ),
                              # Tab select input data 
                              tabPanel("Select QR content", 
                                       checkboxGroupInput("QRcontent", 
                                                          label = h3("Choose content of QR code"), 
                                                          choices = names(inndata),
                                                          selected = names(inndata)[1],inline=TRUE),
                                       p(strong("Preview of QR code content:")),
                                       textOutput("qrcode_content_example")
                              ),

                              
                              # Tab XXXX
                              tabPanel("Table", 
                                       h3("Preview and select input data for labels")
                                       )
                  )
                  
      )
    )
  )
)
