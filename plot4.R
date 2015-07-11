plot4 <- function() {

        
        ## non-english environment -> switch to English necessary
        Sys.setlocale("LC_TIME", "English")
        
        ## install library sqldf if not yet done
        
        if(!require(sqldf)){
                install.packages("sqldf")
                library(sqldf)
        }
        
        ## install library dplyr if not yet done
        
        if(!require(dplyr)){
                install.packages("dplyr")
                library(dplyr)
        }
        
        ## select the required subset of the initial file (>= 1/2/2007 Date <= 2/2/2007)
        ## source must have been downloaded from 
        ## "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        ## to the target directory <working directory>/datasciencecoursera/data
        
        targetdir <- paste(getwd(),"/datasciencecoursera/data", sep = "")
        filesubset <- read.csv.sql(paste(targetdir, "/household_power_consumption.txt", sep = ""), sep = ";", header = TRUE, sql = "select * from file where Date in ('1/2/2007', '2/2/2007') ")
        
        ## add a column containing the combined Date & Time fields in POSIXct format
        
        filesubset2 <- mutate(filesubset, DateTime = as.POSIXct(paste(as.Date(filesubset$Date, format="%d/%m/%Y"), filesubset$Time)))
        
        ## define the filename of the PNG file for the plot
        ## the file will be stored in the subdirectory /datasciencecoursera/data of the current working directory
        
        plotfilename <- paste(targetdir, "/plot4.png", sep = "")
        png(filename = plotfilename, width = 480, height = 480)

        ## set the number of frames (2x2)
        ## plot the different graphs
                
        par(mfrow=c(2,2))
        
        ## plot the first graph containing the overview of global_active_power
        plot(filesubset2$DateTime, filesubset2$Global_active_power, type="l", xlab="", ylab="Global Active Power(Kilowatts)")
        
        ## plot the second graph containing the overview of voltage
        plot(filesubset2$DateTime, filesubset2$Voltage, type="l", xlab="DateTime", ylab="Voltage")
                
        ## plot the third graph combining the sub-metering information
        ##      base graph with view on sub_metering_1
        ##      add the view on sub_metering_2
        ##      add the view on sub_metering_3
        ##      add the legend
        plot(filesubset2$DateTime, filesubset2$Sub_metering_1, type="l", xlab="", ylab="Global Active Power(Kilowatts)")
        lines(filesubset2$DateTime, filesubset2$Sub_metering_2, col = "red")
        lines(filesubset2$DateTime, filesubset2$Sub_metering_3, col = "blue")
        legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1), col= c("black", "red", "blue"))
        
        ## plot the fourth graph containing the overview of global_reactive_power
        plot(filesubset2$DateTime, filesubset2$Global_reactive_power, type="l", xlab="DateTime", ylab="Global Reactive Power")
        
        ## close the PNG file
        
        dev.off()
        
        
}

