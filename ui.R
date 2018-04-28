

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
      sliderInput("textsize", label="Choose text size:", 
                  min=0, max=4, value=1,step=0.05),
      sliderInput("recordNumber", label="Choose recordNumbers:", 
                  min=min(inndata$recordNumber), 
                  max=max(inndata$recordNumber), 
                  value=c(1,10),dragRange=TRUE),
      selectInput('label_template', 'Choose label template:',
                  choices = c("QR only","QR + text","QR + catalogNumber & collectionCode")),
      
      downloadButton('labels')
    ),
    mainPanel(
      verbatimTextOutput("text"),
      #plotOutput('testlabel'),
      imageOutput("labelImage"),
      #tableOutput("table1")
      DT::dataTableOutput("labelDataTable")
    )
  )
)

