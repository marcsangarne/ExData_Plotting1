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



# PLOT 2 shows global active power by day of the week and time
png(file = "plot2.png", bg = "transparent")
plot(two_days_data$DateTime,two_days_data$Global_active_power,type = "l",ylab="Global Active Power (Killowatts)",xlab="")
dev.off()



