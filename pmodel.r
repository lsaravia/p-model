library(lattice)

per <- read.table("p1-075-05-025.sed", skip=2,header=F)
perx <-data.matrix(per)
png("p1-075-05-025.png", width=6,height=6,units="in",res=600)
col.l <- colorRampPalette(c('white', 'green', 'purple', 'yellow', 'red'))(30) 
levelplot(perx, scales = list(draw = FALSE),xlab =NULL, ylab = NULL,col.regions=col.l,
	main=list( "p-model p=1 .75 .5 .25 ",cex=1))
dev.off()

per <- read.table("p1-1-05-05e.sed", skip=2,header=F)
perx <-data.matrix(per)
png("p1-1-05-05e.png", width=6,height=6,units="in",res=600)
col.l <- colorRampPalette(c('white', 'green', 'purple', 'yellow', 'red'))(30) 
levelplot(perx, scales = list(draw = FALSE),xlab =NULL, ylab = NULL,col.regions=col.l,
	main=list( "p-model p=1 1 .5 .5 ",cex=1))
dev.off()

per <- read.table("p1-1-1-0.sed", skip=2,header=F)
perx <-data.matrix(per)
png("p1-1-1-0.png", width=6,height=6,units="in",res=600)
col.l <- colorRampPalette(c('white', 'green', 'purple', 'yellow', 'red'))(30) 
levelplot(perx, scales = list(draw = FALSE),xlab =NULL, ylab = NULL,col.regions=col.l,
	useRaster=T,
	main=list( "p-model p=1 1 1 0",cex=1))
dev.off()

per <- read.table("p1-1-075-075.sed", skip=2,header=F)
png("p1-1-075-075.png", width=6,height=6,units="in",res=600)
col.l <- colorRampPalette(c('white', 'green', 'purple', 'yellow', 'red'))(30) 
levelplot(perx, scales = list(draw = FALSE),xlab =NULL, ylab = NULL,col.regions=col.l,
	useRaster=T,
	main=list( "p-model p=1 1 .75 .75",cex=1))
dev.off()
