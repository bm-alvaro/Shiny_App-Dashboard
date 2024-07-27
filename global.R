# global.R
library(shiny)
library(leaflet)
library(ggplot2)
library(dplyr)
library(shinythemes)
library(shinycssloaders)

# Load data
poland_data <- read.csv("data/poland_data.csv")
multimedia_data <- read.csv("data/multimedia_data.csv")