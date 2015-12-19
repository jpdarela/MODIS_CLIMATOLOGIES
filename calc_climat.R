library(raster)
library(rgdal)


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


#ploting

shape <- readOGR(dsn="C:\\Estagio\\shape", layer="pn_kaparao")

#bands in outpath



day_bands <- get_layers("da_mean_annual")   ### need to link this file to "temp_proc_kpr.R"
night_bands <- get_layers("nt_mean_annual") ## Fix filenammes! This is wrong
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
