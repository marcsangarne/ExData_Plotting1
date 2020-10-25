#Working directory to be updated to your own
setwd("G:/My Drive/Jota MS/R/Github/ExData_Plotting1")

#Download data, unzip
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","./dataset.zip")
unzip("dataset.zip")

#load the data, it looks like my computer can handle it. It turns out to be a ";" separated file, hence csv2 
my_data <- read.csv2('household_power_consumption.txt')
str(my_data)


#Cleanup and processing

#Subset with the two days we are interested in. Extra focus on the date format dd/mm/yyyy. As it turns out, some "0" had to be excluded from the date, in string format
two_days_data <- subset(my_data,Date == '1/2/2007' | Date == '2/2/2007')
#As suggested: convert the Date and Time variables to Date/Time classes in R using strptime() and as.Date() functions. A new DateTime variable is created
two_days_data$Date <- as.Date(two_days_data$Date,"%d/%m/%Y")
two_days_data$DateTime <- strptime(paste(two_days_data$Date," ",two_days_data$Time),"%Y-%m-%d %H:%M:%S")
# Convert other variables to numeric
for (i in 3:9)
        two_days_data[, i] <- as.numeric(as.character(two_days_data[, i]))
str(two_days_data)



# PLOT 4 shows 4 plots: PLOT 2, PLOT3 and two new plots showing Voltage and Global Reactive Power
png(file = "plot4.png", bg = "transparent")
par(mfrow = c(2,2))
plot(two_days_data$DateTime,two_days_data$Global_active_power,type = "l",ylab="Global Active Power",xlab="")
plot(two_days_data$DateTime,two_days_data$Voltage,type = "l",ylab="Voltage",xlab="")
plot(two_days_data$DateTime,two_days_data$Sub_metering_1,type = "l",ylab="Energy Sub Metering",xlab="")
lines(two_days_data$DateTime,two_days_data$Sub_metering_2,col = "red")
lines(two_days_data$DateTime,two_days_data$Sub_metering_3,col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col = c("black", "red", "blue"))
plot(two_days_data$DateTime,two_days_data$Global_reactive_power,type = "l",ylab="Global Reactive Power",xlab="")
dev.off()