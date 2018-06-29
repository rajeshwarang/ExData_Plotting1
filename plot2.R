
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


ggplot(FilteredData , mapping = aes(DateTime ,Global_active_power_num )) +  geom_line()
  

ggsave("plot2.png" , plot = last_plot() , width=12.7 , height=12.7 , units = "cm")

  