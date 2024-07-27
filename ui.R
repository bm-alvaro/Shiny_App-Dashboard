# User Interface definition for the Shiny App
source("modules/species_selectionModule.R")
source("modules/mapModule.R")
source("modules/timelineModule.R")
source("modules/imagesModule.R")

ui <- fluidPage(theme = shinytheme("flatly"),

                # CSS class used to enhance element distribution on the page.
                tags$style(
                  HTML("
                    .custom-spacing {
                      margin-top: 30px;
                    }
                  ")
                ),
                navbarPage("Biodiversity Observations in Poland",
                           tabPanel("Dashboard", 
                                    sidebarPanel(
                                      species_selectionUI("species_selection"),
                                      imagesUI("images")
                                    ),
                                    mainPanel(
                                      mapUI("map"),
                                      div(class = "custom-spacing", 
                                          timelineUI("timeline"))
                                    )
                           ),
                           tabPanel("About",
                                    fluidRow(
                                      column(12, 
                                             h2("About This Application"),
                                             p("This application provides an interactive way to explore biodiversity observations in Poland."),
                                             p("Use the Dashboard tab to search for species, view their geographical distribution on the map, and see observation trends over time."),
                                             p("I hope this tool aids in understanding and appreciating the biodiversity of Poland."), tags$br(),
                                             p(tags$i("Author: Álvaro Benítez, 2024"))
                                      )
                                    )
                           )
                )
)
