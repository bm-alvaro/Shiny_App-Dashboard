# ShinyDev - Biodiversity Observations in Poland

## Overview

This Shiny app provides an interactive platform to explore and visualize biodiversity data specific to Poland. Users can search for species, view their geographical distribution, analyze observation trends over time, and access related images with photographer credits.

## Using the Application

1.  **Dashboard Tab**
    -   **Search for Species**: Type the scientific or common name of the species you are interested in.
    -   **Select Date Range**: Choose a start and end date to filter the observations accordingly.
    -   **Search Button**: Click this to apply your search criteria and view the filtered results.
2.  **Map**
    -   Displays species observation locations on an interactive map.
    -   Click on map markers to view details about specific observations.
3.  **Timeline**
    -   Presents a bar chart showing the number of observations for the selected species by year.
4.  **Images**
    -   Shows images related to the selected species, if available. The image section also includes the photographer’s name.
5.  **About Tab**
    -   Provides background information on the application and credits the author.

## App Structure

-   **User Interface (`ui.R`)**: Defines the layout and appearance of the app.
-   **Server Logic (`server.R`)**: Contains the app's functionality and reactive components.
-   **Modules (`modules/`)**: Contains reusable components for different parts of the app:
    -   `species_selectionModule.R`: Manages species search and date range input.
    -   `mapModule.R`: Handles the map display and updates.
    -   `timelineModule.R`: Manages the timeline plot.
    -   `imagesModule.R`: Displays images and photographer information.
-   **Data (`data/`)**: Directory for CSV files containing the biodiversity and multimedia data.
-   **Preprocessing (`preprocessing/`)**: Directory containing the script used to filter and preprocess raw data.

## Getting Started

To explore the app, visit the live version hosted at [ShinyApps.io](https://alvarobm.shinyapps.io/ShinyDevTask/). Use the app's interactive features to search for species, view their geographical distribution, and analyze observation trends.

## Development Branch

After adding CSS (extra task "Beautiful UI Skill"), I tried to add an image carousel using JavaScript (extra task "JavaScript Skill"). However, I encountered some code errors that I couldn't resolve in time for the deadline, so I will work on fixing them later to complete the task. This work is available in the "development" branch and deployed at the following link: [Unstable App](https://alvarobm.shinyapps.io/ShinyDevTask/)

## Contributing

Feedback and contributions are welcome! If you have suggestions or issues, please reach out via [GitHub Issues](https://github.com/bm-alvaro/ShinyDevTask/issues).

## Contact

For questions or feedback, please contact Álvaro Benítez at [balvarodev@gmail.com](mailto:balvarodev@gmail.com).
