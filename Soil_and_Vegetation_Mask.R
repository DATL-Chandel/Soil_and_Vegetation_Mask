# Load necessary library
library(raster)

# Define file paths
base_path <- "C:\\Define Your Base Path"

# Load spectral bands
blue <- raster(paste0(base_path, "Blue_Band.tif"))
green <- raster(paste0(base_path, "Green_Band.tif"))
red <- raster(paste0(base_path, "Red_Band.tif"))
re <- raster(paste0(base_path, "RedEdge_Band.tif"))
nir <- raster(paste0(base_path, "NearInfrared_Band.tif"))

# Compute NDVI
ndvi <- (nir - red) / (nir + red)

# Define threshold for vegetation and soil separation
ndvi_threshold <- 0.8 # default threshold (Apply the threshold based on the NDVI of your area)

# Create masks
vegetation_mask <- ndvi > ndvi_threshold
soil_mask <- ndvi <= ndvi_threshold

# Apply vegetation mask to retain only vegetation pixels
blue_veg <- blue; blue_veg[!vegetation_mask] <- NA
green_veg <- green; green_veg[!vegetation_mask] <- NA
red_veg <- red; red_veg[!vegetation_mask] <- NA
re_veg <- re; re_veg[!vegetation_mask] <- NA
nir_veg <- nir; nir_veg[!vegetation_mask] <- NA

# Apply soil mask to retain only soil pixels
blue_soil <- blue; blue_soil[!soil_mask] <- NA
green_soil <- green; green_soil[!soil_mask] <- NA
red_soil <- red; red_soil[!soil_mask] <- NA
re_soil <- re; re_soil[!soil_mask] <- NA
nir_soil <- nir; nir_soil[!soil_mask] <- NA

# Save each vegetation spectral band separately
writeRaster(blue_veg, paste0(base_path, "blue_vegetation.tif"), format = "GTiff", overwrite = TRUE)
writeRaster(green_veg, paste0(base_path, "green_vegetation.tif"), format = "GTiff", overwrite = TRUE)
writeRaster(red_veg, paste0(base_path, "red_vegetation.tif"), format = "GTiff", overwrite = TRUE)
writeRaster(re_veg, paste0(base_path, "rededge_vegetation.tif"), format = "GTiff", overwrite = TRUE)
writeRaster(nir_veg, paste0(base_path, "nir_vegetation.tif"), format = "GTiff", overwrite = TRUE)

# Save each soil spectral band separately
writeRaster(blue_soil, paste0(base_path, "blue_soil.tif"), format = "GTiff", overwrite = TRUE)
writeRaster(green_soil, paste0(base_path, "green_soil.tif"), format = "GTiff", overwrite = TRUE)
writeRaster(red_soil, paste0(base_path, "red_soil.tif"), format = "GTiff", overwrite = TRUE)
writeRaster(re_soil, paste0(base_path, "rededge_soil.tif"), format = "GTiff", overwrite = TRUE)
writeRaster(nir_soil, paste0(base_path, "nir_soil.tif"), format = "GTiff", overwrite = TRUE)

# Plot results
plot(ndvi, main = "NDVI Map")
plot(blue_veg, main = "Blue Band (Vegetation)")
plot(blue_soil, main = "Blue Band (Soil)")
plot(green_veg, main = "Green Band (Vegetation)")
plot(green_soil, main = "Green Band (Soil)")
plot(red_veg, main = "Red Band (Vegetation)")
plot(red_soil, main = "Red Band (Soil)")
plot(re_veg, main = "Red-edge Band (Vegetation)")
plot(re_soil, main = "Red-edge Band (Soil)")
plot(nir_veg, main = "NIR Band (Vegetation)")
plot(nir_soil, main = "NIR Band (Soil)")
