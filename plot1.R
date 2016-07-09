## PM2.5 Annual emission
## 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system,  
## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.


library(plyr)
library(ggplot2)
## library(data.table)

## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("./exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory Data Analysis/Source_Classification_Code.rds")

total.emissions <- with(NEI, aggregate(Emissions, by = list(year), sum))

png(filename = "./exploratory Data Analysis/plot1.png", width = 480, height = 480, units = "px")

plot(total.emissions, type = "b", pch = 18, col = "green", ylab = "Emissions", 
     xlab = "Year", main = "Annual Emissions")

# Close the PNG device
dev.off()