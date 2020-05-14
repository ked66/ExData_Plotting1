## Download Data
if(!dir.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./data/power.zip", method = "curl")
power <- read.table(unz("./data/power.zip", "household_power_consumption.txt"), sep = ";", 
                    header = TRUE, na.strings = "?")

## Subset Data to include only necessary dates, combine Date and Time into single POSIXct variable
library(dplyr)
power <- power %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
  subset(Date == "2007-02-01" | Date == "2007-02-02") %>%
  mutate(Time = as.POSIXct(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))

## Open .png
png("plot4.png")

## Set Global Parameters
par(mar = c(6.5, 4.5, 2, 2), mfrow = c(2, 2))

## Upper Left Plot
with(power, plot(Time, Global_active_power, type = "l", 
                 ylab = "Global Active Power", xlab = ""))

## Upper Right Plot
with(power, plot(Time, Voltage, type = "l",
                 xlab = "datetime"))

## Lower Left Plot
with(power, plot(Time, Sub_metering_1, type = "n",
                 xlab = "", ylab = "Energy sub metering"))
with(power, points(Time, Sub_metering_1, type = "l"))
with(power, points(Time, Sub_metering_2, type = "l", col = "red"))
with(power, points(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", lty = 1, bty = "n",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Lower Right Plot
with(power, plot(Time, Global_reactive_power, type = "l",
                 xlab = "datetime"))

## Close .png
dev.off()

