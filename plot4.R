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

# opening plotting device and plotting 

png(filename = "plot4.png" ,width=480, height=480)

par(mfrow = c(2,2))

#plotting first graph (lefttop)

plot(data_for_plot$day_and_time, data_for_plot$Global_active_power, type = "l", ylab = "Global active power", xlab = "")

#plotting second graph (righttop)

plot(data_for_plot$day_and_time, data_for_plot$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

#plotting third graph (leftbottom)

plot(data_for_plot$day_and_time, data_for_plot$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")

lines(data_for_plot$day_and_time, data_for_plot$Sub_metering_2, type = "l", col = "red")

lines(data_for_plot$day_and_time, data_for_plot$Sub_metering_3, type = "l", col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = c(1,1,1), col = c("black", "red", "blue"), cex = 0.85, seg.len=2, bty = "n")

#plotting fourth graph (rightbottom)

plot(data_for_plot$day_and_time, data_for_plot$Global_reactive_power, type ="l", lwd = 0.5, ylab = "Global_reactive_power", xlab = "datetime")

dev.off()

