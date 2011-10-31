options(openfisheries = "carl2011")
## call the queries
global <- openfisheries() 
usa <- openfisheries(country = "USA")

## A nicer ggplot  
require(ggplot2)
dat <- data.frame(year = global$year, global = as.numeric(global$data),
usa=as.numeric(usa$data)) 
dat2 <- melt(dat, id="year")

png("landings.png")
ggplot(dat2, aes(year, value, fill=variable)) + geom_area() 
dev.off()

require(socialR)
upload("landings.png", script="openfisheries.R", tag="fisheries data")

