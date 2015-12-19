library(raster)
library(rgdal)
library(dplyr)

##### PART 1  ----  CREATING A DATA FRAME TO ACCESS DATA. 

# images directory--- fill the variable "input_data_dir" with the pathway to your MOD11A2 images:
input_data_dir = "C:\\Estagio\\raw_datav2\\tidy_data_v2"

filenames <- dir(input_data_dir)

get_meta_data <- function(filename)
{
	# This function is intendend to help the construction of a 
	# dataframe for data access.
	#--------------------------------------------------------------

	# These 3 variables get the metadada (year, day time and julian day) from file name.
	year <- substr(filename,2,3)
	day_time <- substr(filename,11,12)
	year_day <- as.numeric(substr(filename,4,6))

	# I changed the original filenames
	# Example : from "MOD11A2.MRTWEB.A2000217.005.LST_Night_1km" to  "a00217lst_ni"
	# if you want to use the former form of the filename then you might to change the
	# above block of code...
	#                                                                     10        20        30        40
        #                                                            12345678901234567890123456789012345678901	
	# For example: assuming that your filenames are in the form "MOD11A2.MRTWEB.A2000217.005.LST_Night_1km"
	# your 3 variables migth be assigned this way:

	#year =  substr(filename,19,20)
	#day_time <- substr(filename,33,34)
	#year_day <- as.numeric(substr(filename,21,23))

	if (day_time == 'da' || day_time == 'Da') day_string <- 'da'
	if (day_time == 'ni' || day_time == 'Ni') day_string <- 'ni'

	year_init <- paste("20", year,"-01-01" ,sep='')
	year_fini <- paste("20", year,"-12-31" ,sep='')
	dtm <- ifelse(day_string == 'da', "11:00", "23:00")

	date_lookup <- format(seq(as.Date(year_init), as.Date(year_fini), by = "1 day"))

	result <- c(date_lookup[year_day], dtm, year_day, day_string, 
		substr(date_lookup[year_day],6,7),paste(substr(date_lookup[year_day],1,4), sep=''),
		paste(input_data_dir, filename, sep='\\'))
	result
	## END OF FUNCTION DEFINITION
}

counter <- 1
for (filename in filenames)
{
	if (counter == 1)
	{
		line <- get_meta_data(filename)
	}
	else
	{
		line_seq <- get_meta_data(filename)
		line <- rbind(line, line_seq)
	}
	counter <- counter + 1
}
rownames(line) <- seq(1,dim(line)[1])
colnames(line) <- c('date', 'hour', 'j_day', 'day_time', 'month', 'year', 'filename')
df <- data.frame(line, stringsAsFactors=FALSE)
indexes <- c(4,5,6)
for (i in indexes)
{
	df[,i] <- as.factor(df[,i])
}

df <- tbl_df(df)  # this table dataframe will be our data_struct_access 

##### END OF PART ONE
#---------------------------------------------------------------------------------


##### PART TWO ---- defining functions to calculate climatologies, monthly means and 
##### annual means for day, night and day+night

get_layers <- function(data_struct_access, month_mode = FALSE, 
	all_dtm_mode=FALSE, monthc=1, yearc='2000', dtm='da' )
{
	if (month_mode)
	{
		if (!all_dtm_mode) {df <- filter(data_struct_access, month == monthc, day_time == dtm)}
		else {df <- filter(data_struct_access, month == monthc)}
	}
	else
	{
		if(!all_dtm_mode) {df <- filter(data_struct_access, year == yearc, day_time == dtm)}
		else {df <- filter(data_struct_access, year == yearc)}		
	}
	dataset <- stack(df$filename)
	dataset <- brick(dataset) #stack and brick 
	dataset
}

## USAGE EXAMPLE FOR get_layers(): 
## dataset <- get_layers(df, month_mode = T, all_dtm_mode = F, monthc=12, dtm='da')
## this assigns to "dataset" a RasterBrick object containing (all) day images for december

get_layers2 <- function(dtm = 'da', directory = "C:\\Estagio\\raw_datav2\\tidy_data_v2")
{ 
	curr_dir <- getwd()
	setwd(directory)
 	escape <- "\\w+"
 	if(length(i <- grep(paste(escape,dtm,sep=''), dir())))
 	{
 		x <- c()
 		x <- c(dir()[i], x[i])
 		d <- !is.na(x)
 		x <- x[d]
 		dataset <- stack(x)
 	}
 	setwd(curr_dir)
 	dataset <- brick(dataset)
 	dataset
 }


calc_stats <- function(dataset, location_out, mode_c = 'annual', tag= 'testing')
{

	# define a function for calc climatologies
	# and WRITE OUTPUTS
	
	#parameters
	# dataset <- your RasterBrick
	#location_out <- output pathway
	#mode_c <- string --- temporal analysis type
	#tag <- some identifier to you results
	 	
	## transform data and clean bad cells 
	dataset <- (dataset * 0.02) - 273.15
	dataset[dataset == -273.15] <- NA  ## problem ...flting point nbrs

	## stats calcs
	mn <- calc(dataset, fun=min, na.rm=T)
	mx <- calc(dataset, fun=max, na.rm=T)
	mean_ <- calc(dataset, fun=mean, na.rm=T)
	median <- calc(dataset, fun = median, na.rm=T)
	std <- calc(dataset, fun=sd, na.rm=T)

	##############################
	#percentiles.

	q_025 <- function(z,...){quantile(z, probs=c(0.025,NA,NA,NA,NA),na.rm=T)}

	q_975 <- function(z1,...){quantile(z1, probs=c(0.975,NA,NA,NA,NA),na.rm=T)}

	percentile_975 <- calc(dataset, fun=q_975)
	percentile_025 <- calc(dataset, fun=q_025)

	percentile_975 <- raster(percentile_975, layer=1)
	percentile_025 <- raster(percentile_025, layer=1)
	#write output

	writeRaster(mn, paste(location_out,'\\', tag, '_min_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(mx, paste(location_out,'\\', tag, '_max_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(mean_, paste(location_out,'\\', tag, '_mean_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(std, paste(location_out,'\\', tag, '_std_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(median, paste(location_out,'\\', tag, '_med_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(percentile_975, paste(location_out,'\\', tag, '_per_0975_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(percentile_025, paste(location_out,'\\', tag, '_per_0025_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
} 
#-------------------------------------------------------------------------------------------
# Calcular as estatisticas:

# CLIMATOLOGIES
outpath = "C:\\Estagio\\results\\climat"
if (!file.exists(outpath)) dir.create(outpath,recursive=T)
print("CLIMAT")
# climat dia
dataset_day <- get_layers2('da')

# climat noite
dataset_nit <- get_layers2('ni')

# climat tudo
setwd(input_data_dir)
dataset_all <- stack(filenames)
dataset_all <- brick(dataset_all)

print("datasets_assembled... calc and saving")

## Calc ans saving results
calc_stats(dataset_day, outpath, mode_c = 'climat', tag='day')
calc_stats(dataset_nit, outpath, mode_c = 'climat', tag='nig')
calc_stats(dataset_all, outpath, mode_c = 'climat', tag='all')

# ANNUAL
print("ANNUAL")
outpath = "C:\\Estagio\\results\\annual"
if (!file.exists(outpath)) dir.create(outpath, recursive=T)

years <- levels(df$year)
for (i in years) 
{
	dataset_day <- get_layers(df, month_mode = F, all_dtm_mode = F, yearc= i, dtm='da')
	dataset_nit <- get_layers(df, month_mode = F, all_dtm_mode = F, yearc= i, dtm='ni')
	dataset_all <- get_layers(df, month_mode = F, all_dtm_mode = T, yearc= i)

	calc_stats(dataset_day, outpath, mode_c = 'annual', tag=paste('day_', i, sep=''))
	calc_stats(dataset_nit, outpath, mode_c = 'annual', tag=paste('nig_', i, sep=''))
	calc_stats(dataset_all, outpath, mode_c = 'annual', tag=paste('all_', i, sep=''))

}

#MONTHLY
print("MONTHLY")
outpath = "C:\\Estagio\\results\\monthly"
if (!file.exists(outpath)) dir.create(outpath, recursive=T)

months <- levels(df$month)
for (j in months) 
{
	dataset_day <- get_layers(df, month_mode = T, all_dtm_mode = F, monthc = j, dtm='da')
	dataset_nit <- get_layers(df, month_mode = T, all_dtm_mode = F, monthc = j, dtm='ni')
	dataset_all <- get_layers(df, month_mode = T, all_dtm_mode = T, monthc = j)

	calc_stats(dataset_day, outpath, mode_c = 'monthly', tag=paste('day_m', j, sep=''))
	calc_stats(dataset_nit, outpath, mode_c = 'monthly', tag=paste('nig_m', j, sep=''))
	calc_stats(dataset_all, outpath, mode_c = 'monthly', tag=paste('all_m', j, sep=''))
}

#### source plotting climatologies here <---- "calc_climat.R"
#source("calc_climat.R")
# associar aos dados de temp compilados (.CSVs)
