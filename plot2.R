If !file.exists('household_power_consumption.txt'){##Download the file, tidy the data ready for analysis
  
  ##Download the dataset from the url provided
  fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  setInternet2(use=TRUE)
  
  ##Download and unzip the file to the set desination
  dest<-paste(getwd(),"/hpc.zip",sep="",collapse=NULL)
  download.file(fileURL,destfile=dest,mode="wb")
  unzip('hpc.zip')
  
  ##Load the data, subset to the dates required, and add a formatted datetime field
  hpc_full<-read.table('household_power_consumption.txt',sep=";",header=TRUE, na.strings="?",stringsAsFactors=FALSE)
  hpc_sub<-subset(hpc_full,Date=='1/2/2007'|Date=='2/2/2007')
  hpc_sub$DateTime<-strptime(paste(hpc_sub$Date,hpc_sub$Time),"%d/%m/%Y %H:%M:%S")
}
+
##Plot2 - Line chart of Global Active Power by datetime
png('plot2.png',height=480,width=480)
plot(hpc_sub$DateTime,hpc_sub$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type='n')
lines(hpc_sub$DateTime,hpc_sub$Global_active_power)
dev.off()
