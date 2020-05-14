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

## ## Open .png
png("plot2.png")

## Create Plot
with(power, plot(Time, Global_active_power, type = "l", 
                 ylab = "Global Active Power (kilowatts)", xlab = ""))

## Close .png
dev.off()

