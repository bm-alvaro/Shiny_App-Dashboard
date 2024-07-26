source("modules/species_selectionModule.R")
source("modules/mapModule.R")
source("modules/timelineModule.R")
source("modules/imagesModule.R")

server <- function(input, output, session) {
  selected_data <- reactiveVal(NULL)
  
  species_selectionServer("species_selection", function(update) {
    species <- update$species
    date_range <- update$date_range
    
    species_data <- poland_data %>%
      filter((scientificName == species | vernacularName == species) &
               as.Date(eventDate) >= as.Date(date_range[1]) &
               as.Date(eventDate) <= as.Date(date_range[2]))
    
    selected_data(species_data)
    
    output$species_output <- renderUI({
      HTML(paste((paste(sep = " ", "Scientific Name:", unique(species_data$scientificName))), 
                 (paste(sep = " ", "Common Name:", unique(species_data$vernacularName))), 
                 sep = "<br/>"))
    })
  })
  
  mapServer("map", selected_data)
  timelineServer("timeline", selected_data)
  imagesServer("images", selected_data)
}
