library(shiny)
library(shinythemes)
# Define UI for application that draws a histogram
shinyUI(fluidPage(theme = shinytheme("superhero"),
                
  # Application title
  titlePanel("Text Predictor"),
  sidebarPanel(
    h3("The text predictor was built using the N-gram Stupid Back-off model algorithm, specifically the sbo R package."), 
    h3("Instructions:"), 
    h3("- Start typing any word to see your predictions below."),
  ),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      textInput("userInput", "Input your words:")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      verbatimTextOutput("userSentence"),
      br(),
      verbatimTextOutput("prediction1"),
      verbatimTextOutput("prediction2"),
      verbatimTextOutput("prediction3")
    )
  )
))