library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Developing Data Products - Predict length of children"),
    
    sidebarPanel(
      p('This application calculates the expected height of a child based on its gender, and its parents height.'),
      numericInput('father.height', 'Father length (inches)', 67, min = 10, max = 100, step = 1),
      numericInput('mother.height', 'Mother length (inches)', 67, min = 10, max = 100, step = 1),  
      selectInput('child.gender', 'Childs Gender', c("male","female"), selected = NULL,
                  multiple = FALSE)

      ),
    
    mainPanel(
         h4('You have entered the following variables'),
         verbatimTextOutput("father.height"),
         verbatimTextOutput("mother.height"),
         h4('Expected child height:'),
         verbatimTextOutput("child.height"),
         h4('Plot:'),
         p("Your prediction point is given by a red dot")
         plotOutput("plot")
        
      )
    )
    
  )
