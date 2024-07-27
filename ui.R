# User Interface definition for the Shiny App
source("modules/species_selectionModule.R")
source("modules/mapModule.R")
source("modules/timelineModule.R")
source("modules/imagesModule.R")

ui <- fluidPage(
  useShinyjs(), 
  # Link to custom CSS
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    tags$script(src = "script.js")
  ),
  navbarPage("Biodiversity Observations in Poland",
             tabPanel("Dashboard", 
                      sidebarPanel(
                        species_selectionUI("species_selection"),
                        imagesUI("images"),
                        div(class = "container",
                            id = "carouselContainer"
                        )
                      )
                      ),
                      mainPanel(
                        div(class = "box-border",
                            mapUI("map")),
                        div(class = "box-border", 
                            timelineUI("timeline"))
                      )
             )
  )
