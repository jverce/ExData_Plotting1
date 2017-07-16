
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
        sql="SELECT * FROM file WHERE Date IN ('1/2/2007', '2/2/2007')")
} else {
    data <- read.csv2("household_power_consumption.txt")
}


# Data plotting

png(file="plot1.png")

hist(
    data$Global_active_power,
    main="Global Active Power",
    xlab="Global Active Power (kilowatts)", 
    col="red")

dev.off()
