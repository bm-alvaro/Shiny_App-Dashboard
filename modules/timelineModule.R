timelineUI <- function(id) {
  ns <- NS(id)
  plotOutput(ns("timeline"))
}

timelineServer <- function(id, species_data) {
  moduleServer(id, function(input, output, session) {
    output$timeline <- renderPlot({
      if (is.null(species_data())) {
        poland_data %>%
          mutate(year = as.integer(format(as.Date(eventDate), "%Y"))) %>%
          group_by(year) %>%
          summarize(individualCount = sum(individualCount, na.rm = TRUE)) %>%
          ggplot(aes(x = factor(year), y = individualCount)) +
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
      } else {
        species_data() %>%
          mutate(year = as.integer(format(as.Date(eventDate), "%Y"))) %>%
          group_by(year) %>%
          summarize(individualCount = sum(individualCount, na.rm = TRUE)) %>%
          ggplot(aes(x = factor(year), y = individualCount)) +
          geom_col(fill = "#2C3E50") +
          labs(title = paste("Observations of", unique(species_data()$scientificName)), x = "Year", y = "Count") +
          theme(
            plot.title = element_text(size = 20, face = "bold", color = "#2C3E50"),
            axis.title.x = element_text(size = 16, face = "bold", margin = margin(t = 10)),
            axis.title.y = element_text(size = 16, face = "bold", margin = margin(r = 10)),
            axis.text.x = element_text(size = 12, angle = 45, hjust = 1),
            axis.text.y = element_text(size = 12)
          )
      }
    })
  })
}
