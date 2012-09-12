
# change to the directory containing map data

setwd("E:\\Workspace\\RevolutionR\\gmap_demo\\gmap_demo\\makemap\\data")

# ---------- PBSmapping ---------- #

library(sp)
library(maptools) # used here to read shapefiles
library(PBSmapping)

# read in the spatial data
# ...western US state outlines
states <- readShapePoly("western-states")
# ...major western US reservoirs
reservoirs <- readShapePoly("western-reservoirs")
# ...major western US rivers
rivers <- readShapeLines("western-rivers")
# ...locations of several western US dams
dams <- readShapePoints("western-dams")

# convert state polygons to a PolySet object
ps.states <- SpatialPolygons2PolySet(states)
# convert river lines to a PolySet object
ps.rivers <- SpatialLines2PolySet(rivers)
# convert points to an EventData object
ed.dams <- as.EventData(data.frame(EID=1:length(dams@data[,1]),
                                   X=dams@coords[,1], Y=dams@coords[,2]))

png("map-dams-pbsmapping1.png", height=500, width=500)
pdf("map-dams-pbsmapping1.pdf", height=500, width=500)

# start by plotting the states
plotPolys(ps.states, col="wheat1", border="wheat3", cex.lab=1.1)
# add the river lines
addLines(ps.rivers, col="dodgerblue3")
# add the reservoirs
plot(reservoirs, col="darkgreen", border="darkgreen", add=TRUE)
# add dams (circled)
addPoints(ed.dams, cex=1.4, col="darkred")
# add dam labels (using trial and error for placement)
text(dams, labels=as.character(dams$DAM_NAME), col="darkred",
     cex=0.6, font=2, offset=0.5, adj=c(0,2))

# add the map title and legend.
title("Major Dams of the Western United States")
legend("bottomleft", legend=c("Major rivers", "Reservoirs", "Dams"),
       title="Legend", bty="n", inset=0.05,
       lty=c( 1,-1,-1), pch=c(-1,15, 1),
       col=c("dodgerblue3", "darkgreen", "darkred"))

dev.off()