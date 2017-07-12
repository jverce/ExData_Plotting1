if (require(sqldf)) {
    data <- read.csv2.sql(
        "household_power_consumption.txt",
        na.strings="?",
        sql="SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007')")
} else {
    data <- read.csv2("household_power_consumption.txt", na.strings="?")
}

date_time <- paste(data$Date, data$Time)
data$Date.Time <- strptime(date_time, format="%d/%m/%Y %H:%M:%S")

png(file="plot2.png")
with(
    data, plot(
        Date.Time, Global_active_power,
        type="l",
        xlab="",
        ylab="Global Active Power (kilowatts)"))
dev.off()
