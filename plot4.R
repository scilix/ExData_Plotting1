require(tidyverse)

# 1. Read data

# The data needs to be present in the script directory in the folder "exdata_data_household_power_consumption"
raw_data <- read.csv2(file = file.path("exdata_data_household_power_consumption","household_power_consumption.txt"), dec = ".", stringsAsFactors = F)


# 2. prepare and filter data 
# Missing data points are removed in this step.

data <- raw_data %>% 
    mutate(Datetime = as.POSIXct(strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))) %>%
    mutate(Date = as.Date(Date,format = "%d/%m/%Y")) %>% 
    filter(Date == "2007-02-01" | Date == "2007-02-02") %>% 
    filter(Global_active_power != "?") %>% 
    mutate(Global_active_power = as.numeric(Global_active_power))

# 3. create plot

png(filename = "plot4.png", width = 480, height = 480, units = "px")

par(mfrow = c(2,2))

plot(data$Datetime, data$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

plot(data$Datetime, data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

plot(data$Datetime, data$Sub_metering_1, 
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(data$Datetime, data$Sub_metering_2, 
     type = "l",
     col = "red")
lines(data$Datetime, data$Sub_metering_3, 
      type = "l",
      col = "blue")
legend('topright',
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"))

plot(data$Datetime, data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
