library(rts)

# tiles h = c(10:14); v = c(8:12) for brazil

cur_dir <- getwd()
outpath = ("C:\\Estagio\\AF_MODIS_data")
setwd(outpath)


lat <- c(10:14)
long <- c(8:12)

dates_ <- c('2011.01.01', '2011.01.31')
hdf_layers <- '1 0 0 0 1 0 0 0 0 0 0 0'

ModisDownload(x=31,
			h=lat,
			v=long,
			dates=c('2011.01.01', '2011.01.31'))
			#MRTpath='C:\\MRT\\MRT\\bin',
			#mosaic=T,
			#bands_subset = hdf_layers)

			print(getwd())
setwd(cur_dir)

#ModisDownload(x=x,h=c(17,18),v=c(4,5),dates=c('2011.05.01','2011.05.31'),MRTpath='d:/MRT/bin',
#mosaic=T,proj=T,proj_type="UTM",utm_zone=30,datum="WGS84",pixel_size=1000)
