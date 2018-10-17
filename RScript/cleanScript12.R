#Data cleaning script - REUSSA 2017 Fall Detection
#Author: Chris Carpenter
#Version: 1.2
#Notes: Please fix any logic if you find an error. Note that you must change filePath to reflect your
#particular environment, change directory to an appropriate name, and change the parameters windowSize,
#freq, and overlap. This cleaning script formats the data for use in the fall detection app. The data
#will be stored in a csv file in the following order: resultant, cvfast, smax, smin, outcome

#This version is used for Boden's data collection app that stores phone accelerometer data before
#watch accelerometer data

#filePath must be changed to where you have the individual csv files stored
  #filePath = "E:\\Documents\\FallDetectionData_32ms_07282017"
filePath = "C:\\Users\\cha\\Desktop\\IOT2016\\1208 data\\workspace"

setwd(filePath)

#create a directory to store cleaned data in
directory = "Cleaned"
ifelse(!dir.exists(directory), dir.create(directory), "Folder already exists")

#define a function that will combine all csv files in filePath
mergecsv = function(filePath){
  fileNames = list.files(path=filePath, full.names = TRUE, pattern = "csv$")
  dataList = lapply(fileNames, function(x) read.csv(file = x, header = TRUE, stringsAsFactors = FALSE))
  Reduce(function(x,y) rbind(x,y), dataList)
}
data = mergecsv(filePath)

#!!!CHANGE THESE IF THE WINDOW SIZE OR SAMPLING FREQUENCY CHANGES!!!
windowSize = 1000
freq = 32
overlap = .66
#!!!DON'T CHANGE THESE!!!
dataPerChunk = ceiling(windowSize / freq)
middleStart = ceiling(dataPerChunk * (1 - overlap))
jump = floor(dataPerChunk * (1 - overlap))

#replace fall status with 1s and 0s (this is for raw data normal format)
data[32] = lapply(data[33], function(x) gsub("null", "notfall", x))
data[31] = lapply(data[32], function(x) gsub("ACTION_UP", "notfall", x))
data[8] = lapply(data[31], function(x) gsub("ACTION_DOWN", "fall", x))

#remove rows with null for x, y, and z accel
data = data[!(data$ms_accelerometer_x == "null"),]

#calculate resultant accel and write to 7th column
for(i in 1:nrow(data)){
  data[i,7] = sqrt(as.double(data[i,4])^2 + as.double(data[i,5])^2 + as.double(data[i,6])^2)
}

#!!!DON'T CHANGE THIS!!!
chunks = 1 + ceiling((nrow(data) - dataPerChunk) / (dataPerChunk - ceiling(dataPerChunk * overlap)))

xmin = 10000
ymin = 10000
zmin = 10000
xmax = -10000
ymax = -10000
zmax = -10000
min = 10000
max = -10000
cvfast = 0
#calculate smin, smax, and cvfast and write to 4th, 5th, and 6th columns respectively
for(i in 1:chunks){
  if(i == 1){
    xmin = 10000
    ymin = 10000
    zmin = 10000
    xmax = -10000
    ymax = -10000
    zmax = -10000
    min = 10000
    max = -10000
    cvfast = 0
    for(j in 1:dataPerChunk){
      xmin = min(xmin, as.double(data[j,4]))
      ymin = min(ymin, as.double(data[j,5]))
      zmin = min(zmin, as.double(data[j,6]))
      xmax = max(xmax, as.double(data[j,4]))
      ymax = max(ymax, as.double(data[j,5]))
      zmax = max(zmax, as.double(data[j,6]))
      min = min(min, data[j,7])
      max = max(max, data[j,7])
    }
    data[c(1:dataPerChunk),1] = as.double(min)
    data[c(1:dataPerChunk),2] = as.double(max)
    cvfast = sqrt((as.double(xmax) - as.double(xmin))^2 + (as.double(ymax) - as.double(ymin))^2 + (as.double(zmax) - as.double(zmin))^2)
    data[c(1:dataPerChunk),3] = as.double(cvfast)
  }else if(i < chunks){
    xmin = 10000
    ymin = 10000
    zmin = 10000
    xmax = -10000
    ymax = -10000
    zmax = -10000
    min = 10000
    max = -10000
    cvfast = 0
    for(j in (middleStart + (i - 2) * jump):(middleStart + (i - 2) * jump + dataPerChunk - 1)){
      xmin = min(xmin, as.double(data[j,4]))
      ymin = min(ymin, as.double(data[j,5]))
      zmin = min(zmin, as.double(data[j,6]))
      xmax = max(xmax, as.double(data[j,4]))
      ymax = max(ymax, as.double(data[j,5]))
      zmax = max(zmax, as.double(data[j,6]))
      min = min(min, data[j,7])
      max = max(max, data[j,7])
    }
    data[(middleStart + (i - 2) * jump):(middleStart + (i - 2) * jump + dataPerChunk - 1),1] = as.double(min)
    data[(middleStart + (i - 2) * jump):(middleStart + (i - 2) * jump + dataPerChunk - 1),2] = as.double(max)
    cvfast = sqrt((as.double(xmax) - as.double(xmin))^2 + (as.double(ymax) - as.double(ymin))^2 + (as.double(zmax) - as.double(zmin))^2)
    data[(middleStart + (i - 2) * jump):(middleStart + (i - 2) * jump + dataPerChunk - 1),3] = as.double(cvfast)
  }else{
    xmin = 10000
    ymin = 10000
    zmin = 10000
    xmax = -10000
    ymax = -10000
    zmax = -10000
    min = 10000
    max = -10000
    cvfast = 0
    for(j in (middleStart + (i - 2) * jump):nrow(data)){
      xmin = min(xmin, as.double(data[j,4]))
      ymin = min(ymin, as.double(data[j,5]))
      zmin = min(zmin, as.double(data[j,6]))
      xmax = max(xmax, as.double(data[j,4]))
      ymax = max(ymax, as.double(data[j,5]))
      zmax = max(zmax, as.double(data[j,6]))
      min = min(min, data[j,7])
      max = max(max, data[j,7])
    }
    data[(middleStart + (i - 2) * jump):nrow(data),1] = as.double(min)
    data[(middleStart + (i - 2) * jump):nrow(data),2] = as.double(max)
    cvfast = sqrt((as.double(xmax) - as.double(xmin))^2 + (as.double(ymax) - as.double(ymin))^2 + (as.double(zmax) - as.double(zmin))^2)
    data[(middleStart + (i - 2) * jump):nrow(data),3] = as.double(cvfast)
  }
}

#reorder columns
data = data[,c(7,3,2,1,8)]

#rename columns 1-5
colnames(data)[1] = "resultant"
colnames(data)[2] = "cvfast"
colnames(data)[3] = "smax"
colnames(data)[4] = "smin"
colnames(data)[5] = "outcome"

#make sure the types are correct
data$resultant = as.numeric(as.character(data$resultant))
data$cvfast = as.numeric(as.character(data$cvfast))
data$smax = as.numeric(as.character(data$smax))
data$smin = as.numeric(as.character(data$smin))

#remove rows at end with a bunch of NA values if applicable
data = data[!is.na(data$resultant == "null"),]

#write cleaned data to csv in !!separate!! directory (important)
write.csv(data[,c(1:5)], file = paste(filePath, directory, "cleaned_window1000.csv", sep = "/"), row.names = FALSE)

