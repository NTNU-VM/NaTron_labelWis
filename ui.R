
source("dataIO.R")
source("functions.R")

# UI
 # fluidPage(
 #   title = 'Download QR-code labels',
navbarPage("NaTron LabelWisard",
           # first tab of UI
           tabPanel("Basic design",
    sidebarLayout(
      sidebarPanel(
        h1("Choose layout"),
        selectInput('x', 'Choose collection:',
                    choices = c("Fish scales/otoliths")),
        selectInput(
          'dataset',
          'Choose dataset:',
          choices = c("Dodraugen", "Knarrmyra")
        ),
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
        selectInput(
          'bottom_text',
          'Choose bottom text:',
          choices = c("", names(inndata))
        ),
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
      mainPanel(
        h3("Preview of label"),
        imageOutput("labelImage"),
        br(),
        h3("Preview and select input data for labels"),
        p(
          "Select records for printing to labels. Subset table by using the boxes above columns, or the 'search' field"
        ),
        DT::dataTableOutput("labelDataTable")
      )
    )
  ),
  # second tab of UI
  tabPanel("Advanced options",
           sidebarLayout(
             sidebarPanel(checkboxGroupInput("QRcontent", label = h3("Choose content of QR code"), 
                                             choices = names(inndata),
                                             selected = names(inndata)[1],inline=TRUE)
                          ),
             mainPanel(
               h3("Preview of QR code content (showing row 1 of input data"),
               textOutput("qrcode_content_example")
             )
           )
  )
)
