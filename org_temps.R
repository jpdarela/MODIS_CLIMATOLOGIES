# auxiliary file ## DO NOT EXECUTE

parent_dir <- getwd()

df13 <- filter(df, year == 2013)
df14 <- filter(df, year == 2014)

df_13_14 <- rbind(df13,df14)
df_13_14 <- data.frame(df_13_14)

split_date <- function(input, sep = ' ')
{
	number <- strsplit(input, sep)
	date <- number[[1]][1]
	hour <- number[[1]][2]
	result <- c(date, hour)
	result
}

comp_dir <- "C:\\Estagio\\organized_temps\\compiled_temps"
point_coordinates <- read.csv("C:\\Estagio\\code\\MODIS_CLIMATOLOGIES\\obs_points\\obs_points.csv")
filenames2 <- dir(comp_dir)
setwd(comp_dir)

#read the shapefile(observations points)
# iterates over shapefile points

# not in filenames!
# need to change it... 
for (file_ in filenames2)
{
	comp_data <- read.csv(file_, stringsAsFactors=FALSE)
	# create a point feature here
	print(file_)
	for(i in c(1:dim(comp_data)[1]))
	{

	 	date_time <- split_date(comp_data[i,3])
	 	df_aux <- df_13_14
	 	for (line in 1:dim(df_aux)[1])
	 	{	
	 		if (file_ %in% c("pm1.csv", 'sm1.csv', 'sm2.csv', 'terr2.csv')){test <- as.Date(date_time[1])}
	 		else if (file_ %in% c('pm2.csv')){test <- as.Date(date_time[1], format="%m/%d/%y")}
	 		else{test <- as.Date(date_time[1], format="%m/%d/%Y")}

	 		if (as.Date(df_aux[line, 1]) == test)
	 		{
	 			comp_hour_num <- as.numeric(strsplit(date_time[2],':')[[1]][1])
	 			modi_hour_num <- as.numeric(strsplit(df_aux[line,2],':')[[1]][1])
	 			if(modi_hour_num == comp_hour_num)
	 			{
	 				path_to_raster <- df_aux[line, 7]
	 				
	 				cat('data',date_time, as.character(path_to_raster), '\n', sep='---')	
	 			}
	 		}
	 		else{
	 			#cat('not_match\n')
	 			next}
	 	}
	}	
}

setwd(parent_dir)
