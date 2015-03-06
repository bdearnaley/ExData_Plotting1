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

##Plot3 - Line chart overlay of Sub_metering_1, 2 & 3 by datetime
png('plot3.png',height=480,width=480)
plot(hpc_sub$DateTime,hpc_sub$Sub_metering_1,xlab="",ylab="Energy sub metering",type='n')
lines(hpc_sub$DateTime,hpc_sub$Sub_metering_1)
lines(hpc_sub$DateTime,hpc_sub$Sub_metering_2,col="red")
lines(hpc_sub$DateTime,hpc_sub$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),pch=NA,lwd=1,lty=1,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
