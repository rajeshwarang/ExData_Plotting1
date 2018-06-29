


library(reshape2)
library(lubridate)
library(dplyr)
library(ggplot2)

library(gridExtra)

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



FilteredData$Voltage <- as.character(FilteredData$Voltage)

FilteredData$Voltage <- as.numeric(FilteredData$Voltage)


FilteredData$Sub_metering_1 <- as.character(FilteredData$Sub_metering_1)

FilteredData$Sub_metering_2 <- as.character(FilteredData$Sub_metering_2)

FilteredData$Sub_metering_3 <- as.character(FilteredData$Sub_metering_3)


FilteredData$Sub_metering_1 <- as.numeric(FilteredData$Sub_metering_1)

FilteredData$Sub_metering_2 <- as.numeric(FilteredData$Sub_metering_2)

FilteredData$Sub_metering_3 <- as.numeric(FilteredData$Sub_metering_3)



FilteredData$Global_reactive_power <- as.character(FilteredData$Global_reactive_power)


FilteredData$Global_reactive_power <- as.numeric(FilteredData$Global_reactive_power)



MeltedData <- FilteredData [ , c(7,8,9,10)]

MeltedData <- melt(MeltedData , id=c("DateTime"))


par(mfrow=c(2,2))

p1 <- ggplot(FilteredData , mapping = aes(DateTime ,Global_active_power_num )) +  geom_line() 

p2 <- ggplot(FilteredData , mapping = aes(DateTime ,Voltage )) +  geom_line() 

p3 <- ggplot(MeltedData , mapping = aes(DateTime ,value , 
                                  fill=variable )) +  geom_line(aes(color=variable)) + ylab("Energy sub metering")


p4 <- ggplot(FilteredData , mapping = aes(DateTime ,Global_reactive_power )) +  geom_line() 



p5 <- grid.arrange(p1,p2,p3,p4,ncol=2,nrow=2)

p5

ggsave("plot4.png" , plot = last_plot() , width=12.7 , height=12.7 , units = "cm")


