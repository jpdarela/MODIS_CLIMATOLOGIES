library(rgdal)
library(raster)


#setwd("C:\\Estagio\\code")



rm(list=ls())
##day
a2000_day <- vector(mode="character")
a2001_day <- vector(mode="character")
a2002_day <- vector(mode="character")
a2003_day <- vector(mode="character")
a2004_day <- vector(mode="character")
a2005_day <- vector(mode="character")
a2006_day <- vector(mode="character")
a2007_day <- vector(mode="character")
a2008_day <- vector(mode="character")
a2009_day <- vector(mode="character")
a2010_day <- vector(mode="character")
a2011_day <- vector(mode="character")
a2012_day <- vector(mode="character")
a2013_day <- vector(mode="character")
a2014_day <- vector(mode="character")
a2015_day <- vector(mode="character")
#a2016_day = 0 # for posterior use

##nt
a2000_nt <-vector(mode="character")
a2001_nt <-vector(mode="character")
a2002_nt <-vector(mode="character")
a2003_nt <-vector(mode="character")
a2004_nt <-vector(mode="character")
a2005_nt <-vector(mode="character")
a2006_nt <-vector(mode="character")
a2007_nt <-vector(mode="character")
a2008_nt <-vector(mode="character")
a2009_nt <-vector(mode="character")
a2010_nt <-vector(mode="character")
a2011_nt <-vector(mode="character")
a2012_nt <-vector(mode="character")
a2013_nt <-vector(mode="character")
a2014_nt <-vector(mode="character")
a2015_nt <-vector(mode="character")
#a2016_nt = 0 # for posterior use

filesNames_org <- function(wd = character())
{

	#wd == par. ==  MOD11A2 data container
	# rename your files as:
	# aYYDDD_DT
	# onde DT == da (day) or DT == ni(night)
	# sort your directory
	#USE:
	## wd ->> see the function call"

	setwd(wd)
	filenames <- dir()

	indices = c(rep(1,32))

	for (k in 1:length(filenames))
	{
		filename <- filenames[k]
		anus_ = as.numeric(substr(filename,2,3))
		daytime = substr(filename, 11, 13)

		if (daytime == 'da')
		{
			if (anus_ == 0) {a2000_day[indices[1]] <<- filename
			indices[1] = indices [1] + 1}
			
			else if (anus_ == 1) {a2001_day[indices[2]] <<- filename
			indices[2] = indices [2] + 1}
			
			else if (anus_ == 2) {a2002_day[indices[3]] <<- filename
			indices[3] = indices [3] + 1}
			
			else if (anus_ == 3) {a2003_day[indices[4]] <<- filename
			indices[4] = indices [4] + 1}
			
			else if (anus_ == 4) {a2004_day[indices[5]] <<- filename
				indices[5] = indices [5] + 1}

			else if (anus_ == 5) {a2005_day[indices[6]] <<- filename
			indices[6] = indices [6] + 1}

			else if (anus_ == 6) {a2006_day[indices[7]] <<- filename
			indices[7] = indices [7] + 1}

			else if (anus_ == 7) {a2007_day[indices[8]] <<- filename
			indices[8] = indices [8] + 1}

			else if (anus_ == 8) {a2008_day[indices[9]] <<- filename
			indices[9] = indices [9] + 1}

			else if (anus_ == 9) {a2009_day[indices[10]] <<- filename
			indices[10] = indices [10] + 1}

			else if (anus_ == 10) {a2010_day[indices[11]] <<- filename
			indices[11] = indices [11] + 1}

			else if (anus_ == 11) {a2011_day[indices[12]] <<- filename
			indices[12] = indices [12] + 1}

			else if (anus_ == 12) {a2012_day[indices[13]] <<- filename
			indices[13] = indices [13] + 1}

			else if (anus_ == 13) {a2013_day[indices[14]] <<- filename
			indices[14] = indices [14] + 1}

			else if (anus_ == 14) {a2014_day[indices[15]] <<- filename
			indices[15] = indices [15] + 1}

			else {a2015_day[indices[16]] <<- filename
			indices[16] = indices [16] + 1}

			#print(indices)
		}
		else
		{
			if (anus_ == 0){a2000_nt[indices[17]] <<- filename
			indices[17] = indices [17] + 1}
			
			else if (anus_ == 1) {a2001_nt[indices[18]] <<- filename
			indices[18] = indices [18] + 1}
			
			else if (anus_ == 2) {a2002_nt[indices[19]] <<- filename
			indices[19] = indices [19] + 1}
			
			else if (anus_ == 3) {a2003_nt[indices[20]] <<- filename
			indices[20] = indices [20] + 1}
			
			else if (anus_ == 4) {a2004_nt[indices[21]] <<- filename
			indices[21] = indices [21] + 1}

			else if (anus_ == 5) {a2005_nt[indices[22]] <<- filename
			indices[22] = indices [22] + 1}

			else if (anus_ == 6) {a2006_nt[indices[23]] <<- filename
			indices[23] = indices [23] + 1}

			else if (anus_ == 7) {a2007_nt[indices[24]] <<- filename
			indices[24] = indices [24] + 1}

			else if (anus_ == 8) {a2008_nt[indices[25]] <<- filename
			indices[25] = indices [25] + 1}

			else if (anus_ == 9) {a2009_nt[indices[26]] <<- filename
			indices[26] = indices [26] + 1}

			else if (anus_ == 10) {a2010_nt[indices[27]] <<- filename
			indices[27] = indices [27] + 1}

			else if (anus_ == 11) {a2011_nt[indices[28]] <<- filename
			indices[28] = indices [28]+ 1}

			else if (anus_ == 12) {a2012_nt[indices[29]] <<- filename
			indices[29] = indices [29] + 1}

			else if (anus_ == 13) {a2013_nt[indices[30]] <<- filename
			indices[30] = indices [30] + 1}

			else if (anus_ == 14) {a2014_nt[indices[31]] <<- filename
			indices[31] = indices [31] + 1}

			else {a2015_nt[indices[32]] <<- filename
			indices[32] = indices [32] + 1}

			#print(indices)
		} 
	}
}



calc_stats <- function(stack_list=vector(mode='character'), 
	location_out, mode_c = 'annual', tag= 'testing')
{

	# define a function for calc climatologies
	# and WRITE OUTPUTS
	
	#parameters
	#stack_list 



	#stack <-- raster lib
	dataset <- stack(stack_list)
	
	## prep data 
	dataset <- dataset * 0.02 - 273.15
	dataset[dataset == -273.15] <- NA

	## calcs
	mn <- min(dataset, na.rm=T)
	mx <- max(dataset, na.rm=T)
	mean_ <- mean(dataset, na.rm=T)
	std <- calc(dataset, fun=sd, na.rm=T)



##############################
	#percentis.

	#per_0.025 <- qnorm(0.025,as.matrix(dataset))
	#per_0.957 <- qnorm(0.975,as.matrix(dataset))

	#per_0.025 <- raster()


	##write output

	writeRaster(mn, paste(outpath,'\\', tag, '_min_', mode_c, sep=''),
		format='ascii',overwrite=TRUE)
	writeRaster(mx, paste(outpath,'\\', tag, '_max_', mode_c, sep=''),
		format='ascii',overwrite=TRUE)
	writeRaster(mean_, paste(outpath,'\\', tag, '_mean_', mode_c, sep=''),
		format='ascii',overwrite=TRUE)
	writeRaster(std, paste(outpath,'\\', tag, '_std_', mode_c, sep=''),
		format='ascii',overwrite=TRUE)
}


############################ setting environment

outpath = "C:\\Estagio\\results"
inpath = "C:\\Estagio\\raw_datav2\\tidy_data_v2"

### access struct

filesNames_org(inpath)

# mkdir
if (!file.exists(outpath)) dir.create(outpath)
setwd(inpath)


all_files <- dir()


#calling for annual stats

calc_stats(a2000_day,outpath, 'annual','a00_da' )
calc_stats(a2001_day,outpath, 'annual','a01_da' )
calc_stats(a2002_day,outpath, 'annual','a02_da' )
calc_stats(a2003_day,outpath, 'annual','a03_da' )
calc_stats(a2004_day,outpath, 'annual','a04_da' )
calc_stats(a2005_day,outpath, 'annual','a05_da' )
calc_stats(a2006_day,outpath, 'annual','a06_da' )
calc_stats(a2007_day,outpath, 'annual','a07_da' )
calc_stats(a2008_day,outpath, 'annual','a08_da' )
calc_stats(a2009_day,outpath, 'annual','a09_da' )
calc_stats(a2010_day,outpath, 'annual','a10_da' )
calc_stats(a2011_day,outpath, 'annual','a11_da' )
calc_stats(a2012_day,outpath, 'annual','a12_da' )
calc_stats(a2013_day,outpath, 'annual','a13_da' )
calc_stats(a2014_day,outpath, 'annual','a14_da' )
calc_stats(a2015_day,outpath, 'annual','a15_da' )
# #a2016_day = 0 # for posterior usea0'

# ##nt
calc_stats(a2000_nt ,outpath, 'annual','a00_nt')
calc_stats(a2001_nt ,outpath, 'annual','a01_nt')
calc_stats(a2002_nt ,outpath, 'annual','a02_nt')
calc_stats(a2003_nt ,outpath, 'annual','a03_nt')
calc_stats(a2004_nt ,outpath, 'annual','a04_nt')
calc_stats(a2005_nt ,outpath, 'annual','a05_nt')
calc_stats(a2006_nt ,outpath, 'annual','a06_nt')
calc_stats(a2007_nt ,outpath, 'annual','a07_nt')
calc_stats(a2008_nt ,outpath, 'annual','a08_nt')
calc_stats(a2009_nt ,outpath, 'annual','a09_nt')
calc_stats(a2010_nt ,outpath, 'annual','a10_nt')
calc_stats(a2011_nt ,outpath, 'annual','a11_nt')
calc_stats(a2012_nt ,outpath, 'annual','a12_nt')
calc_stats(a2013_nt ,outpath, 'annual','a13_nt')
calc_stats(a2014_nt ,outpath, 'annual','a14_nt')
calc_stats(a2015_nt ,outpath, 'annual','a15_nt')


# climatology

calc_stats(all_files ,outpath, 'climat','all')

setwd("C:\\Estagio\\code")

# calcular a climato geral 