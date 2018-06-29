

library(reshape2)
library(lubridate)
library(dplyr)
library(ggplot2)

rm(list = ls(all=TRUE))

Data <- read.table("household_power_consumption.txt" , sep = ";" , header = TRUE)


str(Data$Date)

Data$Date <- as.character(Data$Date)

Data$Date <-  as.Date(Data$Date , format="%d/%m/%Y")

FilteredData <- Data %>% filter(Date >="2007-02-01" & Date<="2007-02-02")



FilteredData$DateTime <- paste(FilteredData$Date , FilteredData$Time , sep = " ")

str(FilteredData$DateTime)

FilteredData$DateTime <- as.POSIXct(FilteredData$DateTime)

FilteredData$WeekDay <- weekdays(FilteredData$Date)



FilteredData$Global_active_power_num <- as.character(FilteredData$Global_active_power)

FilteredData$Global_active_power_num <- as.numeric(FilteredData$Global_active_power_num)

summary(FilteredData$Global_active_power_num)

str(FilteredData$Sub_metering_2)

# apply(FilteredData[ , c(7:9)], 2, function(x) as.character(x))

FilteredData$Sub_metering_1 <- as.character(FilteredData$Sub_metering_1)

FilteredData$Sub_metering_2 <- as.character(FilteredData$Sub_metering_2)

FilteredData$Sub_metering_3 <- as.character(FilteredData$Sub_metering_3)


FilteredData$Sub_metering_1 <- as.numeric(FilteredData$Sub_metering_1)

FilteredData$Sub_metering_2 <- as.numeric(FilteredData$Sub_metering_2)

FilteredData$Sub_metering_3 <- as.numeric(FilteredData$Sub_metering_3)

FilteredData <- FilteredData [ , c(7,8,9,10)]

MeltedData <- melt(FilteredData , id=c("DateTime"))



EnergyMeterPlot <-    ggplot(MeltedData , mapping = aes(DateTime ,value , 
                            fill=variable )) +  geom_line(aes(color=variable)) + ylab("Energy sub metering")


EnergyMeterPlot 


ggsave("plot3.png" , plot = last_plot() , width=12.7 , height=12.7 , units = "cm")




