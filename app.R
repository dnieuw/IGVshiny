library(IGVshiny)
library(shiny)

runApp(list(
  ui = bootstrapPage(
    tabsetPanel(
    	tabPanel(title = "Input panel",
        h1("Input panel"),
      	fileInput("bam","Choose bam file", accept = ".bam"),
    		fileInput("bai","Choose bai file", accept = ".bai"),
      	actionButton("button", "Run IGV")
      ),
      tabPanel(title = "The IGV panel",
        IGVbrowserOutput("viewer")
      )
    )
  ),
  server = function(input, output) {
  	observeEvent(input$button, {
  		print(input$bam$datapath)
  		print(input$bai$datapath)
  		output$viewer <- renderIGVbrowser({
  		test <- list(IGVtrack(url= input$bam$datapath,
  													indexURL = input$bai$datapath,
                           	name= 'E1000111',
  													type = "alignment",
  													format="bam"))
      	IGVbrowser(tracks = test)
  		})
    })
  }
))