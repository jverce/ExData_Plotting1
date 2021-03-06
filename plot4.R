
# Data downloading

if (!file.exists("household_power_consumption.txt")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, method="curl", destfile="dataset.zip")

    unzip("dataset.zip")
    file.remove("dataset.zip")
}


# Data reading

if (require(sqldf)) {
    data <- read.csv2.sql(
        "household_power_consumption.txt",
        na.strings="?",
        sql="SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007')")
} else {
    data <- read.csv2("household_power_consumption.txt", na.strings="?")
    data <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))
}


# Data plotting

date_time <- paste(data$Date, data$Time)
data$Date.Time <- strptime(date_time, format="%d/%m/%Y %H:%M:%S")

png(file="plot4.png")

par(mfrow=c(2, 2))

with(
    data, plot(
        Date.Time, Global_active_power,
        type="l",
        xlab="",
        ylab="Global Active Power"))

with(
    data, plot(
        Date.Time, Voltage,
        xlab="datetime",
        type="l"))

with(
    data, plot(
        Date.Time, Sub_metering_1,
        type="l",
        xlab="", ylab="Energy sub metering"))
with(data, lines(Date.Time, Sub_metering_2, col="red"))
with(data, lines(Date.Time, Sub_metering_3, col="blue"))
legend(
    "topright", bty="n",
    legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
    col=c("black", "red", "blue"),
    lty=c("solid", "solid", "solid"))

with(
    data, plot(
        Date.Time, Global_reactive_power,
        xlab="datetime",
        type="l"))

dev.off()

