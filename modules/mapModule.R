mapUI <- function(id) {
  ns <- NS(id)
  leafletOutput(ns("map")) %>% withSpinner(color="#3E3F3A")
}

mapServer <- function(id, species_data) {
  moduleServer(id, function(input, output, session) {
    output$map <- renderLeaflet({
      # Default map view if no species data is selected
      if (is.null(species_data())) {
        leaflet(data = poland_data) %>%
          addTiles() %>%
          # Set the focus of the map centered over Poland
          setView(lng = 19.1451, lat = 51.9194, zoom = 6) %>% 
          addCircleMarkers(~longitudeDecimal, ~latitudeDecimal, popup = ~scientificName, color = "#0033FF33")
      # Map view when species data is selected
      } else {
        leaflet(data = species_data()) %>%
          addTiles() %>%
          addCircleMarkers(~longitudeDecimal, 
                           ~latitudeDecimal, 
                           popup = paste(sep= "", species_data()$catalogNumber,
                                         "<br>", species_data()$locality,
                                         "<br>", species_data()$eventDate))
      }
    })
  })
}
