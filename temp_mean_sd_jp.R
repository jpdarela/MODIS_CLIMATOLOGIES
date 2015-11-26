# Temperature calculations from MODIS data

# Loading required packages
library(rgdal)
library(raster) # to read rasters in R

########### IMPORTANT #########################
# Modify path below to match your working folder"
# Change the text below to match you file selection#
##############################################
setwd("C:\\Estagio\\raw_datav2\\tidy_data_v2")
path <- "C:\\Estagio\\k2c"



yr <- "2000_day"  # year, month or season, day or night
seriestype <- "annual" # climatological or annual

###############################################

# Part 1 - Select files for processing

flist <- choose.files() # opens a file selection window, saves result into a variable called flist

# Part 2 - Annual min, max and amplitude

layer.stack <- stack(flist) # stacks all files listed in flist

layer.stack <- layer.stack * 0.02 - 273.15 #calibrates images to celsius

for(b in c(1:dim(layer.stack[3]))){
  temps <- values(layer.stack[[b]])  
  temps[temps==-273.15] <- NA
  values(layer.stack[[b]]) <- temps
}
  
mn <- mean(layer.stack,na.rm=T) # calculates mean

std <- calc(layer.stack, fun=sd, na.rm=T) # calculates standard deviation

mn <- min(layer.stack,na.rm=T) # calculates minimum values ignoring NA values

mx <- max(layer.stack,na.rm=T) # calculates minimum values ignoring NA values

amp <- mx - mn # calculates amplitude


writeRaster(mn,filename=paste(path,"Min_",seriestype,yr,".tif",sep=""),format="GTiff",overwrite=T)

writeRaster(mx,filename=paste(path,"Max_",seriestype,yr,".tif",sep=""),format="GTiff",overwrite=T)

writeRaster(amp,filename=paste(path,"Amp_",seriestype,yr,".tif",sep=""),format="GTiff",overwrite=T)


writeRaster(mn,filename=paste(path,"Mean_",yr,seriestype,".tif",sep=""),format="GTiff",overwrite=T)

writeRaster(std,filename=paste(path,"SD_",yr,seriestype,".tif",sep=""),format="GTiff",overwrite=T)



 