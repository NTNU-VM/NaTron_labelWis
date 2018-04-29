

source("dataIO.R")
source("functions.R")
# UI
fluidPage(
  title = 'Download QR-code labels',
  sidebarLayout(
    sidebarPanel(
      helpText(),
      selectInput('x', 'Choose collection:',
                  choices = c("Fish scales/otoliths")),
      selectInput('dataset', 'Choose dataset:',
                  choices = c("Dodraugen","Knarrmyra")),
      sliderInput("labelWidth", label="Choose labels width:", 
                  min=10, max=150, value=60),
      sliderInput("labelHeigth", label="Choose labels heigth:", 
                  min=10, max=150, value=60),
      sliderInput("labelMargin", label="Choose labels margin:", 
                  min=0.5, max=6, value=4,step=0.5),
      sliderInput("textsize", label="Choose text size:", 
                  min=0, max=4, value=1,step=0.05),
      selectInput('label_template', 'Choose label template:',
                  choices = c("QR only","QR + text","QR + catalogNumber & collectionCode")),
      
      downloadButton('labels')
    ),
    mainPanel(
      h3("Preview of label"),
      imageOutput("labelImage"),
      br(),
      h3("Preview and select input data for labels"),
      p("Select records for printing to labels. Subset table by using the boxes above columns, or the 'search' field"),
      DT::dataTableOutput("labelDataTable")
    )
  )
)

