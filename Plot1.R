# downloading the data

library(downloader)

filename <- "Electric Power Consumption.zip"
if(!file.exists(filename)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download(url, filename, mode = "wb")
}
if(!file.exists("Electric Power Consumption")){
  unzip(filename)}

all_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")

#extracting data for 1/02/2007 and 1/02/2007

days_data <- subset(all_data, Date %in% c("1/2/2007","2/2/2007"))

# converting the data calss for time and date

days_data$Date <- as.Date(days_data$Date,"%d/%m/%Y")

#plotting the graph

hist(days_data$Global_active_power, main = "Global Active Power", col =  "red", xlab = "Global active power (kilowatts)")

#saving the graph as png file

dev.copy (png, "plot1.png", width=480, height=480)
dev.off()

