.PBSfig01 <- function() { # World UTM Zones
  .initPBS()
  clr <- PBSval$PBSclr
  data(worldLL); data(nepacLL)
  par(mfrow=c(1,1),omi=c(0,0,0,0)) #------Plot-the-figure------
  plotMap(worldLL, ylim=c(-90, 90), bg=clr$sea, col=clr$land, tck=-0.023,
          mgp=c(1.9, 0.7, 0), cex=1.2, plt=c(.08,.98,.08,.98))
  # add UTM zone boundaries
  abline(v=seq(-18, 360, by=6), lty=1, col=clr$red)
  # add prime meridian
  abline(v=0, lty=1, lwd=2, col=clr$black)
  # calculate the limits of the 'nepacLL' PolySet
  xlim <- range(nepacLL$X) + 360
  ylim <- range(nepacLL$Y)
  # create and then add the 'nepacLL' rectangle
  region <- data.frame(PID=rep(1,4), POS=1:4, X=c(xlim[1],xlim[2],xlim[2],xlim[1]),
                       Y=c(ylim[1],ylim[1],ylim[2],ylim[2]))
  region <- as.PolySet(region, projection="LL")
  addPolys(region, lwd=2, border=clr$blue, density=0)
  # add labels for some UTM zones
  text(x=seq(183.2, by=6, length=9), y=rep(85,9), adj=0.5, cex=0.65, label=1:9)
  box() }