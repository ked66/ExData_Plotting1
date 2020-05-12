## Download Data
if(!dir.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./data/power.zip", method = "curl")
power <- read.table(unz("./data/power.zip", "household_power_consumption.txt"), sep = ";", 
                    header = TRUE, na.strings = "?")
library(dplyr)
power <- power %>%
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
  subset(Date == "2007-02-01" | Date == "2007-02-02")

## Open .png
png("plot1.png")

## Create Plot
hist(power$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")

## Close .png
dev.off()
