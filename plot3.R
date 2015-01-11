
setwd("C:/Users/david/datasciencecoursera/Exploratory Data Analysis/Week1/proj1")
filename <- "./household_power_consumption.txt"
subsetfile <- "./hpc-subset.Rd"


plotfilename <- "./plot3.png"

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


with(consumption, plot(DateTime, Sub_metering_1, main="", 
                       xlab="", ylab="Energy sub metering",
                       type="n"))

with(consumption, lines(DateTime, Sub_metering_1, col="black"))
with(consumption, lines(DateTime, Sub_metering_2, col="red"))
with(consumption, lines(DateTime, Sub_metering_3, col="blue"))

legend("topright", lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#with(x=consumption$DateTime, 
#     y=consumption$Sub_metering_1, 
#     type="l", xlab="", 
#     ylab="Energy sub metering)",
#     col="black",
#     mar=c(4,5,4,2))

# copy the plot to a png file 
dev.copy(png, file = plotfilename, width=480, height=480)

dev.off()