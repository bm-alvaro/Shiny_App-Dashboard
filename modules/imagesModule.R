imagesUI <- function(id) {
  ns <- NS(id)
  uiOutput(ns("images_output"))
}

imagesServer <- function(id, species_data) {
  moduleServer(id, function(input, output, session) {
    output$images_output <- renderUI({
      species_data <- species_data()
      if (is.null(species_data)) {
        return("Search for a species to show related image")
      }
      
      matched_image <- multimedia_data %>%
        filter(CoreId %in% species_data$id) %>%
        slice(1)
      
      if (nrow(matched_image) > 0) {
        image_url <- matched_image$accessURI
        photographer <- matched_image$creator
        
        tagList(
          tags$img(src = image_url, style = "width:100%; max-width:100%; height:auto;"),
          tags$div(paste("Photo by:", photographer), style = "font-size: 0.8em; color: #888; text-align: right; margin-top: 5px;")
        )
      } else {
        "No image available for this species."
      }
    })
  })
}
