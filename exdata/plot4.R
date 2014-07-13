#Read in data
NEI <- readRDS("exdata/data/summarySCC_PM25.rds")
SCC <- readRDS("exdata/data/Source_Classification_Code.rds")

# Get only coal combustion data
coal <- SCC[grep('Combustion', SCC$Short.Name, fixed=TRUE), ]
coal <- SCC[grep('Coal', coal$Short.Name, fixed=TRUE), ]

coalData <- NEI[NEI$SCC == coal$SCC, ]


aggregated <- aggregate(Emissions ~ year, data = coalData, FUN = sum)

barplot(aggregated$Emissions, aggregated$year, names.arg=aggregated$year, legend.text="PM2.5 Emissions coal combustion sources")

