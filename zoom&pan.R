##################################################################
# a demo for zooming and panning in R graphics
# by Yihui Xie, Feb 20, 2009
##################################################################
# a large number of points
plot(x <- rnorm(5000), y <- rnorm(5000), xlab = "x", ylab = "y")
xylim <- c(range(x), range(y))
zoom <- function(d, speed = 0.05) {
  rx <- speed * (xylim[2] - xylim[1])
  ry <- speed * (xylim[4] - xylim[3])
  # global assignment '<<-' here!
  xylim <<- xylim + d * c(rx, -rx, ry, -ry)
  plot(x, y, xlim = xylim[1:2], ylim = xylim[3:4])
  NULL
}
# Key `+`: zoom in; `-`: zoom out
# Left, Right, Up, Down: self-explaining
# `*`: reset
# Press other keys to quit
keybd <- function(key) {
  switch(key, `+` = zoom(1), `-` = zoom(-1), Left = zoom(c(-1,
                                                           1, 0, 0)), Right = zoom(c(1, -1, 0, 0)), Up = zoom(c(0,
                                                                                                                0, 1, -1)), Down = zoom(c(0, 0, -1, 1)), `*` = plot(x,
                                                                                                                                                                    y), "Quit the program")
}
getGraphicsEvent(onKeybd = keybd)
##################################################################