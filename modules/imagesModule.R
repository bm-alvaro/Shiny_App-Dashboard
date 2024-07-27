imagesUI <- function(id) {
  ns <- NS(id)
  uiOutput(ns("images_output"))
}

imagesServer <- function(id, species_data) {
  moduleServer(id, function(input, output, session) {
    output$images_output <- renderUI({
      # Retrieve the current species data
      species_data <- species_data()
      # Default message if no species data is available
      if (is.null(species_data)) {
        return("Search for a species to show related image")
      }
      
      # Retrieve the first matching image record
      matched_image <- multimedia_data %>%
        filter(CoreId %in% species_data$id)
      
      if (nrow(matched_image) > 0) {
        imageUrls <<- matched_image$accessURI
        photographer <- matched_image$creator
        species_data <- NULL
        # tagList(
          # tags$img(class = "associated_img", src = image_url, style = "width:100%; max-width:100%; height:auto;"),
          # tags$div(class = "img_foot", paste("Photo by:", photographer))
        # )
        # Message when no image is found
      } else {
        "No image available for this species."
      }
    })
  })
}

