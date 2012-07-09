# 加载扩展包
library(ggmap)
library(animation)
library(XML)
# 从网页上抓取数据，并进行清理
webpage <-'http://data.earthquake.cn/datashare/globeEarthquake_csn.html'
tables <- readHTMLTable(webpage,stringsAsFactors = FALSE)
raw <- tables[[6]]
data <- raw[-1,c('V1','V3','V4')]
names(data) <- c('date','lan','lon')
data$lan <- as.numeric(data$lan)
data$lon <- as.numeric(data$lon)
data$date <- as.Date(data$date,  "%Y-%m-%d")
# 用ggmap包从google读取地图数据，并将之前的数据标注在地图上。
ggmap(get_googlemap(center = 'china', zoom=3,maptype='terrain'),extent='device')+
  geom_point(data=data,aes(x=lon,y=lan),colour = 'red',alpha=0.7)+
  stat_density2d(aes(x=lon,y=lan,fill=..level..,alpha=..level..),
                 size=2,bins=4,data=data,geom='polygon')+
<<<<<<< HEAD
                   opts(legend.position = "right")
=======
                   opts(legend.position = "bottomright",padding = 0.02)
>>>>>>> 367624624f0956fcc73dcdd42257dc3d33009a88
