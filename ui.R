

source("dataIO.R")
source("label_templates.R")
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
      sliderInput("imagesize", label="Choose labels size:", 
                  min=10, max=100, value=60),
      sliderInput("textsize", label="Choose text size:", 
                  min=0, max=4, value=1,step=0.05),
      sliderInput("recordNumber", label="Choose recordNumbers:", 
                  min=min(inndata$recordNumber), 
                  max=max(inndata$recordNumber), 
                  value=c(1,10),dragRange=TRUE),
      selectInput('labeltext_1', 'Choose label template:',
                  choices = c("QR only","QR + recordNumber")),
      
      downloadButton('labels')
    ),
    mainPanel(
      verbatimTextOutput("text"),
      plotOutput('testlabel'),
      tableOutput("table1")
    )
  )
)

