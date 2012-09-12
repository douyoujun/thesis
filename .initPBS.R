.initPBS <- function(new=F) {
# Sets up colour table and global settings for the demo figures.
#================================================================
  PBSnam <- c("PBSclr","PBSdot","PBSdash")
  PBSclr <- list(black=c(0,0,0), sea=c(224,253,254), land=c(255,255,195),
                 red=c(255,0,0), green=c(0,255,0), blue=c(0,0,255),
                 yellow=c(255,255,0), cyan=c(0,255,255), magenta=c(255,0,255),
                 purple=c(150,0,150), lettuce=c(205,241,203), moss=c(132,221,124),
                 irish=c(54,182,48), forest=c(29,98,27), white=c(255,255,255),
                 fog=c(223,223,223) )
  if (!exists("PBSval") | new==T | (exists("PBSval") &&
    all(names(PBSval$PBSclr)!=names(PBSclr))) ) {
    require(PBSmapping)
    PBSclr <- lapply(PBSclr,function(v) {rgb(v[1],v[2],v[3],maxColorValue=255) })
    PBSdot <- 3; PBSdash <- 2
    PBSval <- as.list(PBSnam); names(PBSval) <- PBSnam
    for (i in PBSnam) PBSval[[i]] <- get(i)
    assign("PBSval", PBSval, pos=1) } }