# Calcula pmodel espectro multifractal y extrae Dq en un frame
#

calc_pmodel1 <- function(fname,p1,p2,p3,p4,iter=9,rnd=1)
{
  if(p1==0 | iter<2) stop("p1 == 0 or iter<2") 
  if(file.exists(fname))
    file.remove(fname)
  #p2 <- p3 <- p4 <- (1-p1)/3
  syst.txt <- paste("./pmodel", p1,p2,p3,p4,iter,fname,rnd)
  system(syst.txt)
}

plot_pmodel1 <- function(fname,p1,iter=9)
{
  require(lattice)
  per <- read.table(fname, skip=2,header=F)
  per <-data.matrix(per)*(2^(2*iter))
  col.l <- colorRampPalette(c('white', 'green', 'purple', 'yellow', 'brown'))(64) 
  levelplot(per, scales = list(draw = FALSE),xlab =NULL, ylab = NULL,col.regions=col.l,
            useRaster=T,
            main=list( paste("p1=",p1),cex=1))
}

calcDq_mfSBA <- function(fname)
{
  sname <- paste0("s.", fname)
  #  if(!file.exists(sname))
  {
    syst.txt <- paste("../mfsba/mfSBA ",fname, "../mfsba/q21.sed 2 512 20 N")
    system(syst.txt)
  }
  pp <- read.table(sname, header=T)
  
  pp$Dq  <- with(pp,ifelse(q==1,alfa,Tau/(q-1)))
  pp$SD.Dq  <- with(pp,ifelse(q==1,SD.alfa,abs(SD.Tau/(q-1))))
  return(pp[,c("q","Dq","SD.Dq")])
}

plot_Dq <- function(DqCI)
{
  require(lattice)
  with(DqCI,
       xyplot(Dq ~ q, data=DqCI, nx=FALSE, groups=Type, type="l",
              scales=list(tck=-1),
              cap=.01,
              #ylim=c(min(DqCI$LowCI)-.01,max(DqCI$HighCI)+.01),
              panel=function(...){
                panel.abline(h=2, col="grey", lty=2)
                panel.xyplot(...)},
              ylab=expression(italic(D[q])),
              xlab=expression(italic(q)),
              label.curves=F,
              auto.key=list(x=.65,y=.9,title="Type",cex.title=.9, lines=T,points=F,cex=.7),
       )
  )
}

calc_pmodel1('p1-1-1-0R.sed',1,1,1,0,9,'R' )
plot_pmodel1('p1-1-1-0R.sed',1,9)
pDQ <- calcDq_mfSBA('p1-1-1-0R.sed')
pDQ$Type <- "R"
plot_Dq(pDQ)

calc_pmodel1('p1-1-1-0S.sed',1,1,1,0,9,'S' )
plot_pmodel1('p1-1-1-0S.sed',1,9)
pDQ1 <- calcDq_mfSBA('p1-1-1-0S.sed')
pDQ1$Type <- "S"
pDQ <- rbind(pDQ,pDQ1)
plot_Dq(pDQ)

p1 <- 0.4
p2 <- p3 <- p4 <- (1-p1)/3
calc_pmodel1('p0.4R.sed',p1,p2,p3,p4,9,'R' )
plot_pmodel1('p0.4R.sed',.4,9)
pDQ <- calcDq_mfSBA('p0.4R.sed')
pDQ$Type <- "R"

calc_pmodel1('p0.4S.sed',p1,p2,p3,p4,9,'S' )
plot_pmodel1('p0.4S.sed',.4,9)
pDQ1 <- calcDq_mfSBA('p0.4S.sed')
pDQ1$Type <- "S"
pDQ <- rbind(pDQ,pDQ1)

plot_Dq(pDQ)





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

perx <-data.matrix(read.table("p1-1-1-0R.sed", skip=2,header=F))
#png("p1-1-1-0R.png", width=6,height=6,units="in",res=600)
col.l <- colorRampPalette(c('white', 'green', 'purple', 'yellow', 'red'))(30) 
levelplot(perx, scales = list(draw = FALSE),xlab =NULL, ylab = NULL,col.regions=col.l,
          useRaster=T,
          main=list( "p-model p=1 1 1 0 R",cex=1))
dev.off()
