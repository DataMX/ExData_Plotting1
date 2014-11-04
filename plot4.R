#Plot 4
#This assumes you have downloaded and unzipped the file into your working directory

#Assumes that you have lubridate and dplyr 
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
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")
#Set up for 4 panels columnwise
par(mfcol = c(2,2))
#plota
plot( two_days$datetime, two_days$Global_active_power, ylab = "Global Active Power", xlab = " ", type = "l")

#plotb
plot( two_days$datetime, two_days$Sub_metering_1, ylab = "Energy sub metering", xlab = " ", type = "l")
lines( two_days$datetime, two_days$Sub_metering_2, type = "l", col = "red")
lines( two_days$datetime, two_days$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), bty = "n", lwd = 1)

#plotc
plot( two_days$datetime, two_days$Voltage, ylab = "Voltage", xlab = "datetime ", type = "l")

#plotd
plot( two_days$datetime, two_days$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime ", type = "l")

#close graphic device
dev.off()