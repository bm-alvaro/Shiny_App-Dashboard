library(readr)
library(dplyr)

occurence_file <- "./data/occurence.csv"
multimedia_file <- "./data/multimedia.csv"

process_chunk <- function(chunk, pos) {
  chunk %>%
    filter(countryCode == 'PL')
}

poland_data <- data.frame()

callback <- function(chunk, pos) {
  filtered_chunk <- process_chunk(chunk)
  poland_data <<- bind_rows(poland_data, filtered_chunk)
}

occurence_data <- read_csv_chunked(
  file = occurence_file,
  callback = DataFrameCallback$new(callback),
  chunk_size = 1e6,
  col_names = TRUE,
)

write_csv(poland_data, file = "./data/poland_data.csv")

multimedia_data <- read_csv(multimedia_file)

multimedia_data <- multimedia_data %>%
  filter(CoreId %in% poland_data$id)

write_csv(multimedia_data, file = "./data/multimedia_data.csv")

# hist(as.Date(poland_data$eventDate), breaks="years", main="Years Histogram", xlab="Date", ylab="Frequency", col="blue")
# poland_data <- poland_data %>% filter(as.Date(eventDate) > "2004-12-31")
# 
# ggplot(poland_data, aes(x=individualCount)) +
#   geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8)
# poland_data <- poland_data %>% filter(individualCount < 11)
# 
# write_csv(poland_data, file = "./data/poland_data_filtered.csv")
