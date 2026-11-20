# Script to produce a map from a "locations_df.csv" file in the working directory
# Instructions:   (1) install the package (if needed)
#                 (2) upload the file
#                 (3) run the entire script

# load the library
library(leaflet)

# Read the data
data <- read.csv("locations_df.csv", stringsAsFactors = FALSE)

# Create the Leaflet map.
map <- leaflet() %>%
  
  # Add the OpenStreetMap background layer.
  addProviderTiles(
    providers$OpenStreetMap
  ) %>%
  
  # Add one marker for each pizzeria.
  addMarkers(
    data = data,               
    lng = ~Longitude,
    lat = ~Latitude,
    popup = ~paste0("<b>", Location, "</b>: ", Count, " mentions")
  ) 

# Display the completed interactive map.
map
