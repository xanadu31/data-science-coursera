#Read in data
NEI <- readRDS("exdata/data/summarySCC_PM25.rds")
SCC <- readRDS("exdata/data/Source_Classification_Code.rds")

aggregated <- aggregate(Emissions ~ year, data = NEI, FUN = sum)

barplot(aggregated$Emissions, aggregated$year, names.arg=aggregated$year, legend.text="PM2.5 Emissions")