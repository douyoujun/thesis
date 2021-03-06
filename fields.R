x<- 1:10; y<- 1:15; z<- outer( x,y,"+") 

image.plot(x,y,z) 

# or obj<- list( x=x,y=y,z=z); image.plot(obj)

# now add some points on diagonal with some clipping anticipated 
points( 5:12, 5:12, pch="X", cex=3)


image.plot(x,y,z, legend.lab="inches")

# adding breaks and distinct colors for intervals of z
# with and without lab.breaks

brk<- quantile( c(z))
image.plot(x,y,z, breaks=brk, col=rainbow(4))

# annotate legend strip just at break values
image.plot(x,y,z, breaks=brk, col=rainbow(4),
           lab.breaks=names(brk))
#
# compare to 

quantile(c(z), c( .05, .1,.5, .9,.95))-> zp

image.plot(x,y,z, 
           axis.args=list( at=zp, labels=names(zp) ) )


# a log scaling for the colors
ticks<- c( 1, 2,4,8,16,32)
image.plot(x,y,log(z), axis.args=list( at=log(ticks), labels=ticks))

# see help file for designer.colors to generate a color scale that adapts to 
# quantiles of z. 

#
#fat (5 characters wide) and short (50% of figure)  color bar on the bottom
image.plot( x,y,z,legend.width=5, legend.shrink=.5, horizontal=TRUE) 

# adding label with all kinds of additional arguments.
# use side=4 for vertical legend and side= 1 for horizontal legend
# to be parallel to axes. See help(mtext).

image.plot(x,y,z, 
           legend.args=list( text="unknown units",
                             col="magenta", cex=1.5, side=4, line=2))

#### example using a irregular quadrilateral grid
data( RCMexample)

image.plot( RCMexample$x, RCMexample$y, RCMexample$z[,,1])
ind<- 50:75 # make a smaller image to show bordering lines
image.plot( RCMexample$x[ind,ind], RCMexample$y[ind,ind], RCMexample$z[ind,ind,1],
            border="grey50", lwd=2)


#### multiple images with a common legend

set.panel()

# Here is quick but quirky way to add a common legend to several plots. 
# The idea is leave some room in the margin and then over plot in this margin

par(oma=c( 0,0,0,4)) # margin of 4 spaces width at right hand side
set.panel( 2,2) # 2X2 matrix of plots

# now draw all your plots using usual image command
for (  k in 1:4){
  image( matrix( rnorm(150), 10,15), zlim=c(-4,4), col=tim.colors())
}

par(oma=c( 0,0,0,1))# reset margin to be much smaller.
image.plot( legend.only=TRUE, zlim=c(-4,4)) 

# image.plot tricked into  plotting in margin of old setting 

set.panel() # reset plotting device

#
# Here is a more learned strategy to add a common legend to a panel of
# plots  consult the split.screen help file for more explanations.
# For this example we draw two
# images top and bottom and add a single legend color bar on the right side 

# first divide screen into the figure region (left) and legend region (right)
split.screen( rbind(c(0, .8,0,1), c(.8,1,0,1)))

# now subdivide up the figure region into two parts
split.screen(c(2,1), screen=1)-> ind
zr<- range( 2,35)
# first image
screen( ind[1])
image( x,y,z, col=tim.colors(), zlim=zr)

# second image
screen( ind[2])
image( x,y,z+10, col=tim.colors(), zlim =zr)

# move to skinny region on right and draw the legend strip 
screen( 2)
image.plot( zlim=zr,legend.only=TRUE, smallplot=c(.1,.2, .3,.7),
            col=tim.colors())

close.screen( all=TRUE)


# you can always add a legend arbitrarily to any plot;
# note that here the plot is too big for the vertical strip but the
# horizontal fits nicely.
plot( 1:10, 1:10)
image.plot( zlim=c(0,25), legend.only=TRUE)
image.plot( zlim=c(0,25), legend.only=TRUE, horizontal =TRUE)

# combining the  usual image function and adding a legend
# first change margin for some more room
## Not run: 
par( mar=c(10,5,5,5))
image( x,y,z, col=topo.colors(64))
image.plot( zlim=c(0,25), nlevel=64,legend.only=TRUE, horizontal=TRUE,
            col=topo.colors(64))

## End(Not run)
#
# 
# sorting out the difference in formatting between matrix storage 
# and the image plot depiction

A<- matrix( 1:48, ncol=6)
# Note that matrix(c(A), ncol=6) == A
image.plot(1:8, 1:6, A)
# add labels to each box 
text( c( row(A)), c( col(A)), A)
# and the indices ...
text( c( row(A)), c( col(A))-.25,  
      paste( "(", c(row(A)), ",",c(col(A)),")", sep=""), col="grey")

# "columns" of A are horizontal and rows are ordered from bottom to top!
#
# matrix in its usual tabular form where the rows are y  and columns are x

image.plot( t( A[6:1,]), axes=FALSE)