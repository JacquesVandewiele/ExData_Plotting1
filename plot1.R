plot1 <- function() {

        ## install library sqldf if not yet done
        
        if(!require(sqldf)){
                install.packages("sqldf")
                library(sqldf)
        }
        
        ## select the required subset of the initial file (>= 1/2/2007 Date <= 2/2/2007)
        ## source must have been downloaded from 
        ## "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        ## to the target directory <working directory>/datasciencecoursera/data
                
        targetdir <- paste(getwd(),"/datasciencecoursera/data", sep = "")
        
        filesubset <- read.csv.sql(paste(targetdir, "/household_power_consumption.txt", sep = ""), sep = ";", header = TRUE, sql = "select * from file where Date in ('1/2/2007', '2/2/2007') ")
        
        ## define the filename of the PNG file for the first plot
        ## the file will be stored in the subdirectory /datasciencecoursera/data of the current working directory
        
        plotfilename <- paste(targetdir, "/plot1.png", sep = "")
        png(filename = plotfilename, width = 480, height = 480)

        ## plot the histogram
        hist(filesubset$Global_active_power, xlab="Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
        
        ## close the PNG file
        dev.off()
        
}

