#Plot 2 
#This assumes you have downloaded and unzipped the file into your working directory

#Assumes that you have lubridate and dplyr installed 
library (lubridate)
library (dplyr)

#Read Data in
household_power_consumption <- read.csv("~/Documents/Coursera_Data/ExploratoryDataAnalysis/Project1/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

data <- tbl_df (household_power_consumption)
rm (household_power_consumption)

#Convert Date and Time to one column and change  POSIXct using Lubridate dplyr in one step
data <- mutate(data, datetime = dmy_hms(paste(Date, Time, sep = " ")))

#Filter Dates
two_days <- filter (data, floor_date(datetime, unit = "day") == mdy("02/01/2007") | floor_date(datetime, unit = "day") == mdy("02/02/2007") ) 

#Open Device as png, label file, set size and background
png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")
plot( two_days$datetime, two_days$Global_active_power, ylab = "Global Active Power (kilowatts)", xlab = " ", type = "l")
dev.off()