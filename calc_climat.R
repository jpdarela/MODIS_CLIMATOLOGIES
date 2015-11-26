library(raster)
library(rgdal)

# image dir
input_data_dir = "C:\\Estagio\\raw_datav2\\tidy_data_v2" 

# see function fileNames() (L-53) for arquive naming

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

get_layers <- function(name_1='.', directory = "C:\\Estagio\\results\\annual")
{ 
	curr_dir <- getwd()
	setwd(directory)
 	escape <- "\\w+"
 	if(length(i <- grep(paste(year,escape,dtm,sep=''), dir())))
 	{
 		x <- c()
 		x <- c(dir()[i], x[i])
 		d <- !is.na(x)
 		x <- x[d]
 		dataset <- stack(x)
 	}
 	setwd(curr_dir)
 	dataset
 }

 
fileNames_org <- function(wd = character())
{

	#wd parameter ==  MOD11A2 data directory
	# rename your files as:
	# aYYDDD_DT
	# onde DT == da (day) or DT == ni(night)
	#USE:
	## wd ->> see the function call"

	## WARNING
	## This function and preceding lines (L 16-50) migth be modified in case of
	## future data insertions in coming calculations

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
			indices[1] = indices[1] + 1}
			
			else if (anus_ == 1) {a2001_day[indices[2]] <<- filename
			indices[2] = indices[2] + 1}
			
			else if (anus_ == 2) {a2002_day[indices[3]] <<- filename
			indices[3] = indices[3] + 1}
			
			else if (anus_ == 3) {a2003_day[indices[4]] <<- filename
			indices[4] = indices[4] + 1}
			
			else if (anus_ == 4) {a2004_day[indices[5]] <<- filename
				indices[5] = indices[5] + 1}

			else if (anus_ == 5) {a2005_day[indices[6]] <<- filename
			indices[6] = indices[6] + 1}

			else if (anus_ == 6) {a2006_day[indices[7]] <<- filename
			indices[7] = indices[7] + 1}

			else if (anus_ == 7) {a2007_day[indices[8]] <<- filename
			indices[8] = indices[8] + 1}

			else if (anus_ == 8) {a2008_day[indices[9]] <<- filename
			indices[9] = indices[9] + 1}

			else if (anus_ == 9) {a2009_day[indices[10]] <<- filename
			indices[10] = indices[10] + 1}

			else if (anus_ == 10) {a2010_day[indices[11]] <<- filename
			indices[11] = indices[11] + 1}

			else if (anus_ == 11) {a2011_day[indices[12]] <<- filename
			indices[12] = indices[12] + 1}

			else if (anus_ == 12) {a2012_day[indices[13]] <<- filename
			indices[13] = indices[13] + 1}

			else if (anus_ == 13) {a2013_day[indices[14]] <<- filename
			indices[14] = indices[14] + 1}

			else if (anus_ == 14) {a2014_day[indices[15]] <<- filename
			indices[15] = indices[15] + 1}

			else {a2015_day[indices[16]] <<- filename
			indices[16] = indices[16] + 1}

			#print(indices)
		}
		else
		{
			if (anus_ == 0){a2000_nt[indices[17]] <<- filename
			indices[17] = indices[17] + 1}
			
			else if (anus_ == 1) {a2001_nt[indices[18]] <<- filename
			indices[18] = indices[18] + 1}
			
			else if (anus_ == 2) {a2002_nt[indices[19]] <<- filename
			indices[19] = indices[19] + 1}
			
			else if (anus_ == 3) {a2003_nt[indices[20]] <<- filename
			indices[20] = indices[20] + 1}
			
			else if (anus_ == 4) {a2004_nt[indices[21]] <<- filename
			indices[21] = indices[21] + 1}

			else if (anus_ == 5) {a2005_nt[indices[22]] <<- filename
			indices[22] = indices[22] + 1}

			else if (anus_ == 6) {a2006_nt[indices[23]] <<- filename
			indices[23] = indices[23] + 1}

			else if (anus_ == 7) {a2007_nt[indices[24]] <<- filename
			indices[24] = indices[24] + 1}

			else if (anus_ == 8) {a2008_nt[indices[25]] <<- filename
			indices[25] = indices[25] + 1}

			else if (anus_ == 9) {a2009_nt[indices[26]] <<- filename
			indices[26] = indices[26] + 1}

			else if (anus_ == 10) {a2010_nt[indices[27]] <<- filename
			indices[27] = indices[27] + 1}

			else if (anus_ == 11) {a2011_nt[indices[28]] <<- filename
			indices[28] = indices[28]+ 1}

			else if (anus_ == 12) {a2012_nt[indices[29]] <<- filename
			indices[29] = indices[29] + 1}

			else if (anus_ == 13) {a2013_nt[indices[30]] <<- filename
			indices[30] = indices[30] + 1}

			else if (anus_ == 14) {a2014_nt[indices[31]] <<- filename
			indices[31] = indices[31] + 1}

			else {a2015_nt[indices[32]] <<- filename
			indices[32] = indices[32] + 1}

			#print(indices - 1)
		} 
	}
}

calc_stats <- function(stack_list=vector(mode='character'), 
	location_out, mode_c = 'annual', tag= 'testing')
{

	# define a function for calc climatologies
	# and WRITE OUTPUTS
	
	#parameters
	#stack_list <- vector filled with image names
	#location_out <- output pathway
	#mode_c <- string --- temporal analysis type
	#tag <- some identifier to you results

	#stack and brick <-- raster lib <- brick is faster 
	dataset <- stack(stack_list)
	dataset <- brick(dataset)
	
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

	writeRaster(mn, paste(outpath,'\\', tag, '_min_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(mx, paste(outpath,'\\', tag, '_max_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(mean_, paste(outpath,'\\', tag, '_mean_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(std, paste(outpath,'\\', tag, '_std_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(median, paste(outpath,'\\', tag, '_med_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(percentile_975, paste(outpath,'\\', tag, '_per_0975_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
	writeRaster(percentile_025, paste(outpath,'\\', tag, '_per_0025_', mode_c, '.tif', sep=''),
		format='GTiff',overwrite=TRUE)
}


############################ setting environment####################################

### access struct
setwd(input_data_dir) 
fileNames_org(getwd()) #using in my data directory

all_files <- dir() # a porra toda

# mkdirss

#outpath = "C:\\Estagio\\results"
#if (!file.exists(outpath)) dir.create(outpath, recursive=T)

outpath = "C:\\Estagio\\results\\annual"
if (!file.exists(outpath)) dir.create(outpath, recursive=T)

print("calculating and writing annual means")

#calling for annual stats
##da
calc_stats(a2000_day,outpath, 'annual','a00_da')
calc_stats(a2001_day,outpath, 'annual','a01_da')
calc_stats(a2002_day,outpath, 'annual','a02_da')
calc_stats(a2003_day,outpath, 'annual','a03_da')
calc_stats(a2004_day,outpath, 'annual','a04_da')
calc_stats(a2005_day,outpath, 'annual','a05_da')
calc_stats(a2006_day,outpath, 'annual','a06_da')
calc_stats(a2007_day,outpath, 'annual','a07_da')
calc_stats(a2008_day,outpath, 'annual','a08_da')
calc_stats(a2009_day,outpath, 'annual','a09_da')
calc_stats(a2010_day,outpath, 'annual','a10_da')
calc_stats(a2011_day,outpath, 'annual','a11_da')
calc_stats(a2012_day,outpath, 'annual','a12_da')
calc_stats(a2013_day,outpath, 'annual','a13_da')
calc_stats(a2014_day,outpath, 'annual','a14_da')
calc_stats(a2015_day,outpath, 'annual','a15_da')
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


#annual = day+night

a2000 <- c(a2000_day,a2000_nt)
a2001 <- c(a2001_day,a2001_nt)
a2002 <- c(a2002_day,a2002_nt)
a2003 <- c(a2003_day,a2003_nt)
a2004 <- c(a2004_day,a2004_nt)
a2005 <- c(a2005_day,a2005_nt)
a2006 <- c(a2006_day,a2006_nt)
a2007 <- c(a2007_day,a2007_nt)
a2008 <- c(a2008_day,a2008_nt)
a2009 <- c(a2009_day,a2009_nt)
a2010 <- c(a2010_day,a2010_nt)
a2011 <- c(a2011_day,a2011_nt)
a2012 <- c(a2012_day,a2012_nt)
a2013 <- c(a2013_day,a2013_nt)
a2014 <- c(a2014_day,a2014_nt)
a2015 <- c(a2015_day,a2015_nt)



calc_stats(a2000, outpath, "annual_dn", 'a00')
calc_stats(a2001, outpath, "annual_dn", 'a01')
calc_stats(a2002, outpath, "annual_dn", 'a02')
calc_stats(a2003, outpath, "annual_dn", 'a03')
calc_stats(a2004, outpath, "annual_dn", 'a04')
calc_stats(a2005, outpath, "annual_dn", 'a05')
calc_stats(a2006, outpath, "annual_dn", 'a06')
calc_stats(a2007, outpath, "annual_dn", 'a07')
calc_stats(a2008, outpath, "annual_dn", 'a08')
calc_stats(a2009, outpath, "annual_dn", 'a09')
calc_stats(a2010, outpath, "annual_dn", 'a10')
calc_stats(a2011, outpath, "annual_dn", 'a11')
calc_stats(a2012, outpath, "annual_dn", 'a12')
calc_stats(a2013, outpath, "annual_dn", 'a13')
calc_stats(a2014, outpath, "annual_dn", 'a14')
calc_stats(a2015, outpath, "annual_dn", 'a15')



outpath = "C:\\Estagio\\results\\climat"
if (!file.exists(outpath)) dir.create(outpath)

print("calculating and writing climatologies")

#day_alll

day <- c(a2000_day,  a2001_day, a2002_day, a2003_day, 
	a2004_day, a2005_day, a2006_day, a2007_day, 
	a2008_day, a2009_day, a2010_day, a2011_day, 
	a2012_day, a2013_day, a2014_day, a2015_day)

night <-c(a2000_nt, a2001_nt, a2002_nt, a2003_nt, 
	a2004_nt, a2005_nt, a2006_nt, a2007_nt, 
	a2008_nt, a2009_nt, a2010_nt, a2011_nt, 
	a2012_nt, a2013_nt, a2014_nt, a2015_nt)


calc_stats(day, outpath, 'climat', 'da')
calc_stats(night, outpath, 'climat', 'nt')

# climatology


calc_stats(all_files ,outpath, 'climat','all')


#ploting

shape <- readOGR(dsn="C:\\Estagio\\shape", layer="pn_kaparao")

#bands in outpath



day_bands <- get_layers("da_mean_annual")
night_bands <- get_layers("nt_mean_annual")
p025_bands <-  get_layers("_per_0025_annual_dn")
p975_bands <- get_layers("_per_0975_annual_dn")

day_mean <- brick(day_bands)
night_mean <- brick(night_bands)
p975_temp <- brick(p975_bands)
p025_temp <- brick(p025_bands)

# # Extract values

day_means <- extract(x=day_mean,y=shape, fun=mean, na.rm=T, nl=16 )
night_means <- extract(x=night_mean, y=shape,fun=mean, na.rm=T, nl=16)
p975_means <- extract(x=p975_temp, y=shape, fun=mean, na.rm=T, nl=16)
p025_means <- extract(x=p025_temp, y=shape, fun=mean, na.rm=T, nl=16)


plot(c(2000:2015),day_means,type="l",ylim=c(11,35),col="red",main= "da_mean", xlab="Year",ylab="Temperature (Celcius)")
x11()
plot(c(2000:2015),night_means,type="l",ylim=c(5,15),col="red",main= "nt_mean", xlab="Year",ylab="Temperature (Celcius)")
x11()
plot(c(2000:2015),p975_means,type="l",ylim=c(11,35),col="red",main= "p 97.5", xlab="Year",ylab="Temperature (Celcius)")
x11()
plot(c(2000:2015),p025_means,type="l",ylim=c(0,12),col="red",main= "p 0.25", xlab="Year",ylab="Temperature (Celcius)")

#lines(2000:2015,night_means,col="blue")
#lines(2000:2015,p975_means,lty=2,col="red")
#lines(2000:2015,p025_means,lty=2,col="blue")
#legend("topright",c("P97.5%","Média Diurna","Média Noturna","P2.5%"),
#	lty=c(2,1,1,2),col=c("red","red","blue","blue"),cex=1,y.intersp = 0.4,ncol=2)


setwd("C:\\Estagio\\code")