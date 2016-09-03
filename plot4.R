## Exploratory Data Analysis: Course Project 1

## Measurements of electric power consumption in one household with a
## one-minute sampling rate over a period of almost 4 years. Different
## electrical quantities and some sub-metering values are available.

## Download the data set if it is not found in the working directory
if(!("household_power_consumption.txt" %in% dir())) {
    fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileurl, destfile = "electric.zip")
    unzip("electric.zip")
}

## Read only the data from the dates 2007-02-01 and 2007-02-02 into R
electric <- read.table(file = "household_power_consumption.txt",
                       header = TRUE,
                       sep = ";",
                       col.names = c("Date", "Time", "Global_active_power",
                                     "Global_reactive_power", "Voltage",
                                     "Global_intensity", "Sub_metering_1",
                                     "Sub_metering_2", "Sub_metering_3"),
                       na.strings = "?",
                       nrows = 2880,
                       skip = 66636,
                       stringsAsFactors = FALSE)

## Convert Date and Time variables to Date and POSIXlt classes respectively
electric$Date <- as.Date(electric$Date,
                         "%d/%m/%Y")
electric$Time <- strptime(paste(electric$Date, electric$Time),
                          "%Y-%m-%d %H:%M:%S")

## Plot multiple Line Scatterplots to plot4.png
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfcol = c(2,2))

## 1st plot
with(electric, plot(Time, Global_active_power,
                    xlab = "",
                    ylab = "Global Active Power",
                    type = "l"))

## 2nd plot
with(electric, plot(Time, Sub_metering_1,
                    col = "black",
                    xlab = "",
                    ylab = "Energy sub metering",
                    type = "l"))
with(electric, lines(Time, Sub_metering_2,
                     col = "red"))
with(electric, lines(Time, Sub_metering_3,
                     col = "blue"))
legend("topright",
       lty = "solid",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty = "n")

## 3rd plot
with(electric, plot(Time, Voltage,
                    xlab = "datetime",
                    ylab = "Voltage",
                    type = "l"))

## 4th plot
with(electric, plot(Time, Global_reactive_power,
                    xlab = "datetime",
                    ylab = "Global_reactive_power",
                    type = "l"))

dev.off()
