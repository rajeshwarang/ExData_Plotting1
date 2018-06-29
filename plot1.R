

rm(list = ls(all=TRUE))

Data <- read.table("household_power_consumption.txt" , sep = ";" , header = TRUE)


str(Data$Date)

Data$Date <- as.character(Data$Date)

Data$Date <-  as.Date(Data$Date , format="%d/%m/%Y")

FilteredData <- Data %>% filter(Date >="2007-02-01" & Date<="2007-02-02")

summary(FilteredData$Global_active_power)

FilteredData$Global_active_power_num <- as.character(FilteredData$Global_active_power)

FilteredData$Global_active_power_num <- as.numeric(FilteredData$Global_active_power_num)

summary(FilteredData$Global_active_power_num)


ggplot(FilteredData , mapping = aes(Global_active_power_num )) + geom_histogram(binwidth = 0.3 , 
      fill="red" ) + xlim(0,6) + ylim(0,1250) + xlab("Global Active Power (kilowatts)") + ylab("Frequency") + ggtitle("Global Active Power")                       

ggsave("plot1.png" , plot = last_plot() , width=12.7 , height=12.7 , units = "cm")

