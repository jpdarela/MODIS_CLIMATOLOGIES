library(rgdal)
library(dplyr)
library(raster)


input_data_dir <- "C:\\Estagio\\raw_datav2\\tiles\\h12v11"
local_code_dir <- getwd()
output_data_dir = "C:\\Estagio_t2\\new_results2"


get_meta_data <- function(filename)
{
	year =  substr(filename,19,20)
	day_time <- substr(filename,40,41)
	year_day <- as.numeric(substr(filename,21,23))

	if (day_time == 'da' || day_time == 'Da') day_string <- 'da'
	if (day_time == 'ni' || day_time == 'Ni') day_string <- 'ni'

	year_init <- paste("20", year,"-01-01" ,sep='')
	year_fini <- paste("20", year,"-12-31" ,sep='')
	dtm <- ifelse(day_string == 'da', "13:00:00", "01:00:00")

	date_lookup <- format(seq(as.Date(year_init), as.Date(year_fini), by = "1 day"))

	result <- c(date_lookup[year_day], dtm, year_day, day_string, 
		substr(date_lookup[year_day],6,7),paste(substr(date_lookup[year_day],1,4), sep=''),
		paste(input_data_dir, filename, sep='\\'))
	result
}


get_layers <- function(data_struct_access, week_mode= FALSE, month_mode = FALSE, 
	all_dtm_mode=FALSE, yearc='2000', monthc=1,  dtm='da', julian_day= '1')
{	
	if (!week_mode)
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
		#dataset <- brick(dataset) #stack and brick 
		dataset
	}
	else
	{
		if(!all_dtm_mode) {df <- filter(data_struct_access, j_day == julian_day, day_time == dtm)}
		else {df <- filter(data_struct_access, j_day == julian_day)}
	    dataset <- stack(df$filename)
		#dataset <- brick(dataset) #stack and brick 
		dataset
	}
}


calc_stats <- function(dataset, location_out= 'a', mode_c = 'annual', tag= 'testing')
{
	nlayers <- dim(dataset)[3]
	dataset_list <- list()
	
	#dataset <- dataset * 0.02
	
	for (i in c(1:nlayers))
	{
		layer_ <- raster(dataset, layer=i)
		layer_[layer_ == 0] <- NA
		std_ <- cellStats(layer_, sd)
		mean_ <- cellStats(layer_, mean)
		outliar_out <- mean_ - (std_)
		
		layer_[layer_ <= outliar_out] <- NA
		layer_ <- layer_ * 0.02
		layer_ <- layer_ - 273.15
		dataset_list[i] <- layer_
	}
		
	dataset <- stack(dataset_list)
	dataset <- brick(dataset)
	dataset

	# stats calcs(
	mn <- calc(dataset, fun=min, na.rm=T)
	mx <- calc(dataset, fun=max, na.rm=T)
	mean_ <- calc(dataset, fun=mean, na.rm=T)
	median <- calc(dataset, fun = median, na.rm=T)
	std <- calc(dataset, fun=sd, na.rm=T)
	q_025 <- function(z,...){quantile(z, probs=c(0.025,NA,NA,NA,NA),na.rm=T)}
	q_975 <- function(z1,...){quantile(z1, probs=c(0.975,NA,NA,NA,NA),na.rm=T)}

	percentile_975 <- calc(dataset, fun=q_975)
	percentile_025 <- calc(dataset, fun=q_025)
	percentile_975 <- raster(percentile_975, layer=1)
	percentile_025 <- raster(percentile_025, layer=1)

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
#######____________________________________________________________________________________________

filenames <- dir(input_data_dir)
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
indexes <- c(3, 4 , 5, 6)
for (i in indexes)
{
	df[,i] <- as.factor(df[,i])
}
df <- tbl_df(df)

## END of PART 2
##-------------------------------------------------------------------------------------------

## PART 3 - CALCULATING STATS AND SAVING RESULTS
#
## CLIMATOLOGIES
#
#outpath = paste(output_data_dir, "\\" , "results\\climat", sep='')
#if (!file.exists(outpath)) dir.create(outpath,recursive=T)
#
## climat day
#dataset_day <- get_layers2('Da')
#
## climat night
#dataset_nit <- get_layers2('Ni')
#
## climat all
#setwd(input_data_dir)
#dataset_all <- stack(filenames)
#dataset_all <- brick(dataset_all)
#
### Calc and saving results
#calc_stats(dataset_day, outpath, mode_c = 'climat', tag='day')
#calc_stats(dataset_nit, outpath, mode_c = 'climat', tag='nig')
#calc_stats(dataset_all, outpath, mode_c = 'climat', tag='all')
##--------------------------------------------------------------
#
#
## ANNUAL
#
#outpath = paste(output_data_dir, "\\" , "results\\annual", sep='')
#if (!file.exists(outpath)) dir.create(outpath, recursive=T)
#
#years <- levels(df$year)
#for (i in years) 
#{
	#dataset_day <- get_layers(df, month_mode = F, all_dtm_mode = F, yearc= i, dtm='da')
	#dataset_nit <- get_layers(df, month_mode = F, all_dtm_mode = F, yearc= i, dtm='ni')
	#dataset_all <- get_layers(df, month_mode = F, all_dtm_mode = T, yearc= i)
#
	#calc_stats(dataset_day, outpath, mode_c = 'annual', tag=paste('day_', i, sep=''))
	#calc_stats(dataset_nit, outpath, mode_c = 'annual', tag=paste('nig_', i, sep=''))
	#calc_stats(dataset_all, outpath, mode_c = 'annual', tag=paste('all_', i, sep=''))
#
#}
##--------------------------------------------------------------
#
#
##MONTHLY
#
#outpath = paste(output_data_dir, "\\" , "results\\monthly", sep='')
#if (!file.exists(outpath)) dir.create(outpath, recursive=T)
#
#months <- levels(df$month)
#for (j in months) 
#{
	#dataset_day <- get_layers(df, month_mode = T, all_dtm_mode = F, monthc = j, dtm='da')
	#dataset_nit <- get_layers(df, month_mode = T, all_dtm_mode = F, monthc = j, dtm='ni')
	#dataset_all <- get_layers(df, month_mode = T, all_dtm_mode = T, monthc = j)
#
	#calc_stats(dataset_day, outpath, mode_c = 'monthly', tag=paste('day_m', j, sep=''))
	#calc_stats(dataset_nit, outpath, mode_c = 'monthly', tag=paste('nig_m', j, sep=''))
	#calc_stats(dataset_all, outpath, mode_c = 'monthly', tag=paste('all_m', j, sep=''))
#}
##--------------------------------------------------------------
#

## WEEKLY COMPOSITES
# 
# outpath = paste(output_data_dir, "\\" , "results\\weekly", sep='')
# if (!file.exists(outpath)) dir.create(outpath, recursive=T)
# 
# week_composites <- levels(df$j_day)
# for (k in week_composites)
# {
# 	dataset_day <- get_layers(df, week_mode=T, all_dtm_mode = F, dtm='da', julian_day = k)
# 	dataset_nit <- get_layers(df, week_mode=T, all_dtm_mode = F, dtm='ni', julian_day = k)
# 	dataset_all <- get_layers(df, week_mode=T, all_dtm_mode = T, dtm='all', julian_day = k)
# 	
# 	calc_stats(dataset_day, outpath, mode_c = 'week_comp', tag=paste('day_d', k, sep=''))
# 	calc_stats(dataset_nit, outpath, mode_c = 'week_comp', tag=paste('nig_d', k, sep=''))
#  	calc_stats(dataset_all, outpath, mode_c = 'week_comp', tag=paste('all_d', k, sep=''))
# }

## END OF PART 3

## --------------------------------------------------------
##                         ... 
### source plotting climatologies script here <---- "calc_climat.R

#source(paste(local_code_dir, "calc_climat.R", sep = '\\'))