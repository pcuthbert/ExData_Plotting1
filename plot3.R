## Exploratory Data Analysis
## Course Project #1

### NOTE: This script downloads the zipped file from the link provided in the assignment, unzips it
### and only reads in the necessary subset of lines for Feb 1/07 - Feb 2/07


        if(!file.exists('projectfile.zip')){
                url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                        download.file(url,destfile = "projectfile.zip")
        }
        
                unzip("projectfile.zip")
 
                               
## Read in only required lines for Feb 1/07 to Feb 2/07 to make it load many times faster
        
        df <- read.table("household_power_consumption.txt",skip= 66637 ,nrows= 2880, sep = ";")


## Load in a required package for next steps
        
        library(data.table)

## Change column names to something suitable (ie. using original headers, but no punctuation and/or capitals)

        setnames(df, old=c("V1","V2","V3","V4","V5","V6","V7","V8","V9"), 
         new=c("date", "time", "globalactivepower", "globalreactivepower", "voltage", "globalintensity", "submetering1", "submetering2", "submetering3"))

## Create a single date/time column

        df$datetime <- with(df, as.POSIXct(paste(date, time), format="%d/%m/%Y %H:%M:%S"))

## Filter & Reorder columns to bring datetimestamp over the leftmost column

        df <- df[c("datetime","globalactivepower", "globalreactivepower", "voltage", "globalintensity", "submetering1", "submetering2", "submetering3")]


## Create Plot 3

## Open PNG device; create 'plot3.png' in the working directory

        png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")

## Create the plot, lines and legend and send to a file (no plot will appear on screen)

        with(df, plot(datetime, submetering1, type = "l", xlab = "", ylab = "Energy sub metering"))
        with(df, lines(datetime, submetering2, type = "l", col = "red"))
        with(df, lines(datetime, submetering3, type = "l", col = "blue"))

        legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))

## close the PNG file device
        
        dev.off()

## The file 'plot3.png' can now found in the working directory and be viewed on your computer 

