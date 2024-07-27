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
             ),
             tabPanel("About",
                      fluidRow(
                        div(class = "about_p", column(12, 
                               h2("About This Application"),
                               p("This application provides an interactive way to explore biodiversity observations in Poland."),
                               p("Use the Dashboard tab to search for species, view their geographical distribution on the map, and see observation trends over time."),
                               p("I hope this tool aids in understanding and appreciating the biodiversity of Poland."), tags$br(),
                               p(tags$i("Author: Álvaro Benítez, 2024")))
                        )
                      )
             )
  )
