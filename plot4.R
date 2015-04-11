require(data.table)
require(dplyr)
require(datasets)

# to have labels in English
Sys.setlocale("LC_ALL","C")

# download and unzip the dataset and filter it for dates 2007-02-01 and 2007-02-01 
# as requested in the course project
if(!file.exists("household_power_consumption_filtered.csv")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile = "household_power_consumption.zip",
                  method = "curl")
    
    unzip(zipfile="household_power_consumption.zip")
    
    powerConsumption <- fread("household_power_consumption.txt",
                              na.strings = '?'
    )
    
    # the date format of the filter is according to the Italian R Studio settings
    powerConsumption <- filter(powerConsumption, Date == '1/2/2007' | Date == '2/2/2007')
    
    write.csv(powerConsumption, 
              "household_power_consumption_filtered.csv",
              row.names = FALSE
    )    
} 

powerConsumption <- read.csv("household_power_consumption_filtered.csv")

# plot 4 generation
# the background color of the plot is transparent according to the figures 
# included in the original repository
png(file = "plot4.png", bg = "transparent")

par(mfrow = c(2, 2))

powerConsumption$Timestamp <- strptime(paste(powerConsumption$Date, powerConsumption$Time), 
                                       format = '%d/%m/%Y %H:%M:%S')

with(powerConsumption, {
    plot(powerConsumption$Timestamp, powerConsumption$Global_active_power, 
         type = 'l',
         main = '',
         xlab = '',
         ylab= 'Global Active Power'     
    )
    plot(powerConsumption$Timestamp, powerConsumption$Voltage, 
         type = 'l',
         main = '',
         xlab = 'datetime',
         ylab= 'Voltage'     
    )
    plot(powerConsumption$Timestamp, as.numeric(powerConsumption$Sub_metering_1),
         type = 'n',
         main = '',
         xlab = '',
         ylab= 'Energy sub metering'
    )
    
    points(powerConsumption$Timestamp, as.numeric(powerConsumption$Sub_metering_1), 
           type = 'l')
    
    points(powerConsumption$Timestamp, as.numeric(powerConsumption$Sub_metering_2), 
           type = 'l', col = 'red')
    
    points(powerConsumption$Timestamp, as.numeric(powerConsumption$Sub_metering_3), 
           type = 'l', col = 'blue')
    
    legend('topright', legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
           col = c('black', 'red', 'blue'), lty = 1, bty = 'n')
    
    plot(powerConsumption$Timestamp, powerConsumption$Global_reactive_power, 
         type = 'l',
         main = '',
         xlab = 'datetime',
         ylab= 'Global_reactive_power'     
    )
    
})

dev.off()