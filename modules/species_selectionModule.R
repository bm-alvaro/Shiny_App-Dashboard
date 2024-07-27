species_selectionUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectizeInput(ns("species_search"),
                   "Enter Species Name:",
                   choices = NULL,
                   options = list(
                     create = FALSE,
                     placeholder = 'Type to search...',
                     onInitialize = I('function() { this.setValue(""); }'))),
    dateRangeInput(ns("date_range"), "Select Date Range:",
                   start = min(poland_data$eventDate),
                   end = max(poland_data$eventDate)),
    actionButton(ns("search_button"), "Search"),
    htmlOutput(ns("species_output")),
    uiOutput(ns("images_output"))
  )
}

species_selectionServer <- function(id, update) {
  moduleServer(id, function(input, output, session) {
    updateSelectizeInput(session, "species_search",
                         choices = unique(c(poland_data$scientificName, poland_data$vernacularName)), 
                         options = list(
                           create = FALSE, 
                           placeholder = 'Type to search...',
                           onInitialize = I('function() { this.setValue(""); }')), 
                         server = TRUE)
    
    observeEvent(input$search_button, {
      species <- input$species_search
      date_range <- input$date_range
      update(list(species = species, date_range = date_range))
      runjs(sprintf("showCarousel(%s);",toJSON(imageUrls)))
      session$sendCustomMessage("refrescarDiv", NULL)
    })
    
    output$species_output <- renderUI({
      NULL  # Placeholder, actual rendering will be handled in main server
    })
    
    output$images_output <- renderUI({
      NULL  # Placeholder, actual rendering will be handled in main server
    })
  })
}
