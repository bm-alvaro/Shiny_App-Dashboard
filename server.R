# This script will load the needed modules and define the server function

source("modules/species_selectionModule.R")
source("modules/mapModule.R")
source("modules/timelineModule.R")
source("modules/imagesModule.R")

server <- function(input, output, session) {
  # Creating a reactive value to store species data when updated by user input
  selected_data <- reactiveVal(NULL)
  imageUrls_react <- reactiveVal(NULL)
  # Filtering data on user input's conditions
  species_selectionServer("species_selection", function(update) {
    species <- update$species
    date_range <- update$date_range
    
    species_data <- poland_data %>%
      filter((scientificName == species | vernacularName == species) &
               as.Date(eventDate) >= as.Date(date_range[1]) &
               as.Date(eventDate) <= as.Date(date_range[2]))
    
    # Updating the reactive value with the filtered species data
    selected_data(species_data)
    
    # Render UI to display the scientific and common names of the selected species
    output$species_output <- renderUI({
      HTML(paste((paste(sep = " ", "Scientific Name:", unique(species_data$scientificName))), 
                 (paste(sep = " ", "Common Name:", unique(species_data$vernacularName))), 
                 sep = "<br/>"))
    })
  })
  
  # Calling server logic for each specific module
  mapServer("map", selected_data)
  timelineServer("timeline", selected_data)
  imagesServer("images", selected_data)
}
