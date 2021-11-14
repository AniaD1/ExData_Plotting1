# changing language for plot descriptions
Sys.setlocale("LC_TIME", "English")

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

Feb_data <- subset(all_data, Date %in% c("1/2/2007","2/2/2007"))

# converting the data calss for time and date

Feb_data$Date <- as.Date(Feb_data$Date,"%d/%m/%Y")

day_and_time <- paste(Feb_data$Date,Feb_data$Time)

day_and_time <- strptime(day_and_time, format = "%Y-%m-%d %H:%M:%S")

data_for_plot <- cbind(Feb_data, day_and_time)

#plotting the graph

plot(data_for_plot$day_and_time, data_for_plot$Global_active_power, type = "l", ylab = "Global active power (kilowatts)", xlab = "")

#saving the graph as png file

dev.copy (png, "plot2.png", width=480, height=480)
dev.off()
