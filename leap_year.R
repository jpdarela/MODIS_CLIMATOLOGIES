is_leap_year <- function(year)
{
	if (is.character(year)) year <- as.numeric(year)
	if ((year %% 400) == 0 ) 
	{
		result = TRUE
	} 
	else if (year %% 100 == 0) 
	{
		result = FALSE
	}
	else if (year %% 4 == 0)
	{
		result = TRUE
	}
	else
	{
		result = FALSE
	}
	result
}

filename <- "a00065lst_ni"

get_meta_data <- function(filename)
{

	year_init <- paste("20",substr(filename,2,3),"-01-01" ,sep='')
	year_fini <- paste("20",substr(filename,2,3),"-12-31" ,sep='')
	dtm <- ifelse(substr(filename,11,11) == 'd', "14:00", "2:00") 
	year_day <- as.numeric(substr(filename,4,6))
	date_lookup <- format(seq(as.Date(year_init), as.Date(year_fini), by = "1 day"))

	result <- c(date_lookup[year_day], dtm, year_day, filename)
	result
}


# 	escape <- "\\w+"
# 	if(length(i <- grep(paste(year,escape,dtm,sep=''), dir())))
# 	{
# 		x <- c()
# 		x <- c(dir()[i], x[i])
# 		d <- !is.na(x)
# 		x <- x[d]
# 		#dataset <- stack(x)
# 	#setwd(curr_dir)
# }