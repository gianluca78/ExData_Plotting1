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

# plot 1 generation
# the background color of the plot is transparent according to the figures 
# included in the original repository
png(file = "plot1.png", bg = "transparent")

hist(as.numeric(powerConsumption$Global_active_power), 
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency",
     col = 'red',
     main = 'Global Active Power'
)

dev.off() 

