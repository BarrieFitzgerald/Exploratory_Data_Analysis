## setting working directory, creating any needed folders, downdloading data set, 
        ## and importing the data file.
        ## NOTE: SOME OF THESE STEPS MAY NOT NEED TO BE RAN AGAIN.
setwd("C:/Users/bdfitzgerald/Desktop/Data Science Specialist")
if(!file.exists("exploratory_data_analysis")){dir.create("exploratory_data_analysis")}
setwd("C:/Users/bdfitzgerald/Desktop/Data Science Specialist/exploratory_data_analysis")
if(!file.exists("course_project_1")){dir.create("course_project_1")}
setwd("C:/Users/bdfitzgerald/Desktop/Data Science Specialist/
      exploratory_data_analysis/course_project_1")
fileurl <- ("https://d396qusza40orc.cloudfront.net/
            exdata%2Fdata%2Fhousehold_power_consumption.zip")
download.file(fileurl, destfile = 'electric_power_consumption.zip', mode = "wb")
unzip("electric_power_consumption.zip")
files <- list.files(, full.names = TRUE)
data_full <- read.csv(files[2], sep = ";", header = TRUE)


## making data adjustments, and subsetting the data
data_full$Date <- as.Date(data_full$Date, format="%d/%m/%Y")
data <- subset(data_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Making plot and saving it
with(data, {
        plot(Sub_metering_1~Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()