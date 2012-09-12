# 为了保证高质量的PNG图片，这里用附加包cairoDevice
# 如果读者对图片质量要求不高，也可以用R自带的png()设备
# 即png("points-desktop.png", width = 1366, height = 768)
library(cairoDevice)
Cairo_png("points-desktop.png", width = 13.66 * 1.39,
          height = 7.68 * 1.39)
par(mar = c(0, 0, 0, 0))
n = 76
set.seed(711)
plot.new()
size = c(replicate(n, 1/rbeta(2, 1.5, 4)))
center = t(replicate(n, runif(2)))
center = center[rep(1:n, each = 2), ]
color = apply(replicate(2 * n, sample(c(0:9, LETTERS[1:6]),
                                      8, replace = TRUE)), 2, function(x) sprintf("#%s", paste(x,
                                                                                               collapse = "")))
points(center, cex = size, pch = rep(20:21, n), col = color)
dev.off()