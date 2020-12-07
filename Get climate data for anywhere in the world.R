#Extract historical climate data for anywhere in the world
#Code written by Hilary Rose Dawson, Dec 2020

##Download data from worldclim.org and unzip folder before use.
##Run the function separately for each climate variable (precip, Tavg, etc.).
##Use the join functions from dplyr to combine into one climate data set.

#You will need:
##folderpath: folder address of downloaded worldclim data
####eg "worldclim/tavg"
##points: an object with latitude and longitude columns

#You will also need the following packages:
library(raster)
library(sp)
library(reshape)
library(purrr)
library(dplyr)
library(tidyr)

#Make 'points' into a spatial object. 
##Replace "lon" and "lat" with appropriate column names.
sp::coordinates(points) = ~lon+lat

#Create functions for extracting climate data from rasters by location.
##Place cursor in first line of function and press 'run'. 

##extract.clim is for all variables with multiple rasters (this is most variables)
extract.clim = function(folderpath, points) {
  #Read rasters
  files <- dir(folderpath, pattern = "*.tif") 
  #Combine rasters into a rasterStack
  alldata <- files%>%
    map(~ raster(file.path(folderpath, .))) %>% 
    reduce(stack)
  #extract raster data for each point
  data = raster::extract(alldata, points)
  #Calculate statistics
  datasum = data %>%
    melt()%>%
    pivot_wider(names_from = X2, values_from = value)%>%
    bind_cols(as.data.frame(points))%>%
    mutate(total = rowSums(across(where(is.numeric))),
           mean = rowMeans(across(where(is.numeric))))
  
}

#basic.clim is for variables with a single raster (elevation)
#Again, put cursor in first line and run
basic.clim = function(folderpath, points) {
  #Read rasters
  files <- dir(folderpath, pattern = "*.tif") 
  #Combine rasters into a rasterStack
  alldata <- files%>%
    map(~ raster(file.path(folderpath, .))) %>% 
    reduce(stack)
  #extract raster data for each point
  data = alldata %>%
    raster::extract(points)%>%
    melt()%>%
    bind_cols(as.data.frame(points))
}

#Then use the functions as if they came in a CRAN package
#Examples:
prec = extract.clim("datasets/worldclim/precip/", points)%>%
  #Create unique ID for each point
  unite(lat_lon, c("lat", "lon"))%>%
  #Select just the relevant columns
  ##notice that precip. uses total, not mean
  select(total, lat_lon)%>%
  #Rename so you know total what
  dplyr::rename(tot.prec = total)

tavg = extract.clim("datasets/worldclim/tavg/", points)%>%
  unite(lat_lon, c("lat", "lon"))%>%
  ##Notice that Tavg uses mean, not total
  select(mean, lat_lon)%>%
  dplyr::rename(tavg = mean)

elev = basic.clim("datasets/worldclim/elev/", points)%>%
  unite(lat_lon, c("lat", "lon"))%>%
  rename(elev = value)

#Once extracted, you can combine all the data into one metadata object.
clim.meta = points %>%
  as.data.frame()%>%
  unite(lat_lon, c("lat", "lon"))%>%
  inner_join(prec)%>%
  inner_join(tavg)%>%
  inner_join(elev))
