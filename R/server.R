poland_data <- read.csv("C:/Users/Alvaro/Desktop/Alvaro/Scripts/Appsilon/ShinyDevTask/data/poland_data.csv")

server <- function(input, output, session) {
  
  updateSelectizeInput(session, "species_search", 
                       choices = unique(c(poland_data$scientificName, poland_data$vernacularName)), 
                       server = TRUE)
  
  observeEvent(input$search_button, {
    species <- input$species_search
    date_range <- input$date_range
    
    # Filter data for the selected species
    species_data <- poland_data %>%
      filter((scientificName == species | vernacularName == species) &
               as.Date(eventDate) >= as.Date(date_range[1]) &
               as.Date(eventDate) <= as.Date(date_range[2]))
    
    # Update map
    output$map <- renderLeaflet({
      leaflet(data = species_data) %>%
        addTiles() %>%
        addCircleMarkers(~longitudeDecimal, 
                         ~latitudeDecimal, 
                         popup = paste(sep= "", species_data$catalogNumber,
                                        "<br>", species_data$locality))
    })
    
    # Update timeline
    output$timeline <- renderPlot({
      # Aggregate data by year
      species_data <- species_data %>%
        mutate(year = as.integer(format(as.Date(eventDate), "%Y"))) %>%
        group_by(year) %>%
        summarize(individualCount = sum(individualCount, na.rm = TRUE))
      
      ggplot(species_data, aes(x = factor(year), y = individualCount)) +
        geom_col(fill = "#2C3E50") +
        labs(title = paste("Observations of", species), x = "Year", y = "Count") +
        theme(
          plot.title = element_text(size = 20, face = "bold", color = "#2C3E50"),
          axis.title.x = element_text(size = 16, face = "bold", margin = margin(t = 10)),
          axis.title.y = element_text(size = 16, face = "bold", margin = margin(r = 10)),
          axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
          axis.text.y = element_text(size = 12)
        )
    })
    
    output$species_output <- renderUI({
      HTML(paste((paste(sep = " ", "Scientific Name:", unique(species_data$scientificName))), (paste(sep = " ", "Common Name:", unique(species_data$vernacularName))), sep = "<br/>"))
    })
  })

  # Default map view
  output$map <- renderLeaflet({
    leaflet(data = poland_data) %>%
      addTiles() %>%
      setView(lng = 19.1451, lat = 51.9194, zoom = 6) %>%
      addCircleMarkers(~longitudeDecimal, ~latitudeDecimal, popup = ~scientificName, color = "#0033FF33")
  })
  
  # Default timeline view
  output$timeline <- renderPlot({
    # Aggregate data by year
    poland_data <- poland_data %>%
      mutate(year = as.integer(format(as.Date(eventDate), "%Y"))) %>%
      group_by(year) %>%
      summarize(individualCount = sum(individualCount, na.rm = TRUE))
    
    ggplot(poland_data, aes(x = factor(year), y = individualCount)) +
      geom_col(fill = "#2C3E50") +
      labs(title = "Select a species to see observation data", x = "Year", y = "Count") +
      theme(
        plot.title = element_text(size = 20, face = "bold", color = "#2C3E50", margin = margin(b = 20)),
        axis.title.x = element_text(size = 16, face = "bold", margin = margin(t = 10)),
        axis.title.y = element_text(size = 16, face = "bold", margin = margin(r = 10)),
        axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 12),
        panel.background = element_rect(fill = "white"),
        plot.background = element_rect(fill = "white"),
        panel.grid.major = element_line(color = "gray90"),
        panel.grid.minor = element_blank()
      )
  })
}
