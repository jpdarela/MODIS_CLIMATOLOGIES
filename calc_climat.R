# auxiliary file ## DO NOT EXECUTE

get_layers3 <- function(dtm='all', statistics_type = 'mean' , directory = paste(output_data_dir, "results\\annual", sep='\\'))

{ 
	curr_dir <- getwd()
	setwd(directory)
 	escape <- "\\w+"
 	if(length(i <- grep(paste(dtm, escape, statistics_type, escape, sep=''), dir())))
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

### formal arguments for get_layers3
#   dtm can assume: 'all', 'day', 'nig'
#   statistcs_type can assume: 'med' for median,'mean','per_0025','per_0975'

#ploting

shape <- readOGR(dsn="C:\\Estagio\\shape", layer="pn_kaparao")

#bands in outpath

# filenames examples 
 
## MEDIAN  day + nit + all 
#  all <- all_2000_med_annual
#  day <- day_2000_med_annual
#  nig <- nig_2000_med_annual

## MEAN  day + nit + all
#  all <- all_2000_mean_annual
#  day <- day_2000_mean_annual
#  nig <- nig_2000_mean_annual

## PER_0025  day + nit + all
#  all <- all_2000_per_0025_annual
#  day <- day_2000_per_0025_annual
#  nig <- nig_2000_per_0025_annual

## PER_0975  day + nit + all
#  all <- all_2000_per_0975_annual
#  day <- day_2000_per_0975_annual
#  nig <- nig_2000_per_0975_annual


all_bands <- get_layers3('all', 'mean')
day_bands <- get_layers3('day', 'mean')
night_bands <- get_layers3('nig', 'mean') 
p025_bands <-  get_layers3('all', 'per_0025')
p975_bands <- get_layers3('all', 'per_0975')


all_mean <- brick(all_bands)
day_mean <- brick(day_bands)
night_mean <- brick(night_bands)
p975_temp <- brick(p975_bands)
p025_temp <- brick(p025_bands)

# # Extract values
# mean or median?
all_means <- extract(x=all_mean,y=shape, fun=mean, na.rm=T, nl=16 )
day_means <- extract(x=day_mean,y=shape, fun=mean, na.rm=T, nl=16 )
night_means <- extract(x=night_mean, y=shape,fun=mean, na.rm=T, nl=16)
p975_means <- extract(x=p975_temp, y=shape, fun=mean, na.rm=T, nl=16)
p025_means <- extract(x=p025_temp, y=shape, fun=mean, na.rm=T, nl=16)

## Need to improve climatology plots
## need to automate plotting (y argument of plot function)

x_axis <- levels(df$year)
plot(x_axis,all_means,type="l",ylim=c(0,35),col="green",main= "all_mean", xlab="Year",ylab="Temperature (Celcius)") 

lines(x_axis,day_means,type="l",ylim=c(0,35),col="green",main= "da_mean", xlab="Year",ylab="Temperature (Celcius)")

lines(x_axis,night_means,type="l",ylim=c(0,35),col="green",main= "nt_mean", xlab="Year",ylab="Temperature (Celcius)")

lines(x_axis,p975_means,type="l",ylim=c(0,35),col="red",main= "p 97.5", xlab="Year",ylab="Temperature (Celcius)")

lines(x_axis,p025_means,type="l",ylim=c(0,35),col="blue",main= "p 0.25", xlab="Year",ylab="Temperature (Celcius)")

#lines(2000:2015,night_means,col="blue")
#lines(2000:2015,p975_means,lty=2,col="red")
#lines(2000:2015,p025_means,lty=2,col="blue")
#legend("topright",c("P97.5%","Média Diurna","Média Noturna","P2.5%"),
#	lty=c(2,1,1,2),col=c("red","red","blue","blue"),cex=1,y.intersp = 0.4,ncol=2)


setwd(local_code_dir)
