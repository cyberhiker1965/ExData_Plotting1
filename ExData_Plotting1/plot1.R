
setwd("C:/Users/david/datasciencecoursera/Exploratory Data Analysis/Week1/proj1/ExData_Plotting1")
filename <- "./household_power_consumption.txt"
subsetfile <- "./hpc-subset.Rd"


plotfilename <- "./plot1.png"

if (file.exists(plotfilename)) {
  file.remove(plotfilename)
}


# if the datsubset already exists read it in,
# otherwise read in the original file and subset it

if (file.exists(subsetfile)) {
  load(subsetfile)
} else {

  consumption <- read.table(filename, header=TRUE, sep=";",na.strings="?",as.is=TRUE,
                        colClasses = c("character","character",rep("numeric",7)))

  # subset so we only have the data for the two dates

  consumption <- subset( consumption, consumption$Date == "1/2/2007" | consumption$Date == "2/2/2007")

  # create a date / time column 
  consumption$DateTime <- paste(consumption$Date, consumption$Time)
  consumption$DateTime <- strptime( consumption$DateTime, "%d/%m/%Y %H:%M:%S")

  # now save the subset for future use
  save(consumption, file=subsetfile)
}



hist(consumption$Global_active_power,col="red",
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)" )

# copy the plot to a png file 
dev.copy(png, file = plotfilename, width=480, height=480)

dev.off()
