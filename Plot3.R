#Change Language to English
Sys.setlocale("LC_TIME", "English")

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zip_file <- "data.zip"

download.file(url, zip_file, method="curl")

unzip(zip_file)

#Read Data

data_file <- "./household_power_consumption.txt"

start_line <- grep("1/2/2007",readLines(data_file))[1]

end_line <- grep("3/2/2007",readLines(data_file))[1]-1

classes <- c(rep("character", 2), rep("numeric", 7))

data<- read.table(data_file, skip=start_line-1, nrows=end_line - start_line + 1, sep = ";", 
                  colClasses = classes)

#Extract title
title <- read.table(data_file, nrows = 1, sep = ";")
title <- sapply(title, function(vec) as.character(vec[1]))

# entitle 
names(data)[1:9] <- title

data$DateTime <- paste(data$Date , data$Time)

data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

#open device
png (filename = "plot3.png")
 
# draw plot
plot(data$DateTime, data$Sub_metering_1,  type="l", xlab = "", 
     ylab = "Energy sub metering", main = "")
	 
lines(data$DateTime, data$Sub_metering_2,  type="l", col="red")
lines(data$DateTime, data$Sub_metering_3,  type="l", col="blue")

# draw legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
	   col = c("black", "red", "blue"), 
	   lty = c(1, 1 ,1))
	   
#close device
dev.off()
