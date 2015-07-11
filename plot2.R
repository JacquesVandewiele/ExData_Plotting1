plot2 <- function() {

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
        
        plotfilename <- paste(targetdir, "/plot2.png", sep = "")
        png(filename = plotfilename, width = 480, height = 480)

        ## plot the requested graph
        
        plot(filesubset2$DateTime, filesubset2$Global_active_power, type="l", xlab="", ylab="Global Active Power(Kilowatts)")

        ## close the PNG file
        dev.off()
                
}

