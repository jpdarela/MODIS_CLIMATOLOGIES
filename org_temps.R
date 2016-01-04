# auxiliary file ## DO NOT EXECUTE

split_date <- function(input, sep = ' ')
{
	number <- strsplit(input, sep)
	date <- number[[1]][1]
	hour <- number[[1]][2]
	result <- c(date, hour)
	result
}

comp_dir <- "C:\\Estagio\\organized_temps\\compiled_temps"
filenames2 <- dir(comp_dir)
setwd(comp_dir)

#read the shapefile(points of observations)
# iterates over shapefile points

# not in filenames!
# need to change it... 
for (i in filenames2)
{
	comp_data <- read.csv(i, stringsAsFactors=FALSE)

	# for(i in c(1:dim(comp_data)[1]))
	# {
	# 	z <- split_date(comp_data[i,3])
	# 	# HERE search for correspondent data in df
	# 	# EXTRACT the LST in point
	# 	# append to compiled temps 
	# 	print(z)
	# }

	print(i)

	print(dim(comp_data))
	print(colnames(comp_data))
}

# date_df <- paste(df[1,1], df[1,2],sep=' ')
# date_df <- as.POSIXct(date_df)

# date_df2 <- as.POSIXct(df2[567,3])
# setwd('C:\\Estagio\\code')

# date_df - date_df2

#tbl <- read.csv("C:\\Estagio\\organized_temps\\compiled_temps\\inters.csv", stringsAsFactor=F)





