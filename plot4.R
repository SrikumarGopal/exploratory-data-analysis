## Emissions from Coal Combustion for the US
## you have to install data.table package: install.packages("data.table") 
## 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

library(plyr)
library(ggplot2)
library(data.table)

## This first line will likely take a few seconds. Be patient!

NEI <- readRDS("./exploratory Data Analysis/summarySCC_PM25.rds")
SCC <- readRDS("./exploratory Data Analysis/Source_Classification_Code.rds")

## Convert into data.table
NEI.DT = data.table(NEI)
SCC.DT = data.table(SCC)

coal.scc = SCC.DT[grep("Coal", SCC.Level.Three), SCC]

coal.emissions = NEI.DT[SCC %in% coal.scc, sum(Emissions), by = "year"]
colnames(coal.emissions) <- c("year", "Emissions")

png(filename='./exploratory Data Analysis/plot4.png', width=480, height=480, units='px')

g = ggplot(coal.emissions, aes(year, Emissions))
g + geom_point(color = "red") + geom_line(color = "green") + labs(x = "Year") + 
    labs(y = expression("Total Emissions, PM"[2.5])) + labs(title = "Emissions from Coal Combustion for the US")


# Close the PNG device
dev.off()
