library(IGVshiny)
library(shiny)

runApp(list(
  ui = bootstrapPage(
    tabsetPanel(
      tabPanel(title = "The IGV panel",
        IGVbrowserOutput("viewer")
      ),
      tabPanel(title = "The other panel",
        h1("The other panel")
      )
    )
  ),
  server = function(input, output) {
  		output$viewer <- renderIGVbrowser({ 
      IGVbrowser("")
    })
  }
))