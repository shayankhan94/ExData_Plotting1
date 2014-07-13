prepareData <- function() {
    file1 = "data.csv"
    if(file.exists(file1)) { #it doesn't matter if you have the file="household_power_consumption.txt" this would download the file if executed the first time
        data=read.csv(file1)
        data$DateTime=strptime(data$DateTime, "%Y-%m-%d %H:%M:%S")
    }
    else {
        url="http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
		filename="household_power_consumption.zip"
		download.file(url, destfile=filename)
        unzip("household_power_consumption.zip")
        data= read.table("household_power_consumption.txt",header=TRUE,sep=';', na.strings='?',colClasses=c(rep('character', 2),rep('numeric', 7)))
        temp1=subset(data,Date=="1/2/2007")
        temp2=subset(data,Date=="2/2/2007")
        data=rbind(temp1,temp2)
		data$DateTime=strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
        write.csv(data, file1)
    }
    data
}
