library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(shinythemes)
library(shinycssloaders)

ui <- fluidPage(theme = shinytheme("flatly"),
                navbarPage("Biodiversity Observations in Poland:",
                           tabPanel("Map", 
                                    sidebarPanel(
                                      selectizeInput("species_search", "Enter Species Name:", choices = NULL, 
                                                     options = list(create = TRUE, placeholder = 'Type to search...')),
                                      dateRangeInput("date_range", "Select Date Range:",
                                                     start = min(poland_data$eventDate),
                                                     end = max(poland_data$eventDate)),
                                      actionButton("search_button", "Search"),
                                      htmlOutput("species_output")
                                    ),
                                    mainPanel(
                                      leafletOutput("map") %>% withSpinner(color="#3E3F3A"),
                                      plotOutput("timeline")
                                    )
                           ),
                           # 
                           # tabPanel("Search in Dat", 
                           #          sidebarPanel(
                           #            textInput("directory_dat", "Directory:", value = ""),
                           #            textInput("search_string_dat", "Search term:", value = ""),
                           #            actionButton("submit_dat", "Search"),
                           #            br(),
                           #            br(),
                           #            downloadButton("download_results_dat", "Download Results")
                           #          ),
                           #          mainPanel(
                           #            tableOutput("results_dat") %>% withSpinner(color="#3E3F3A")
                           #          )
                           # ),
                           # 
                           # tabPanel("Search by Position",
                           #          sidebarPanel(
                           #            textInput("directory_pos", "Directory:", value = ""),
                           #            textInput("chromosome_input", "Chromosome name:", value = ""),
                           #            textInput("position_input", "Position number:", value = ""),
                           #            actionButton("submit_position", "Search"),
                           #            br(),
                           #            br(),
                           #            downloadButton("download_results_position", "Download Results")
                           #          ),
                           #          mainPanel(
                           #            tableOutput("results_position") %>% withSpinner(color="#3E3F3A")
                           #          )
                           # ),
                           # 
                           # tabPanel("About",
                           #          titlePanel("About"), 
                           #          div(includeMarkdown("D:/Datos/Escritorio/Alvaro/Scripts/GitHub/Scripts-UAL/R/RShiny/VCF_viewer/about.md"), 
                           #              align="justify")
                           # )
                           
                )
)