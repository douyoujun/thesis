plotfunc <- function(x) {
  df <- subset(data,date <= x)
  df$lan <- as.numeric(df$lan)
  df$lon <- as.numeric(df$lon)
  p <- ggmap(get_googlemap(center = 'china', zoom=4,maptype='terrain'),,extent='device')+
    geom_point(data=df,aes(x=lon,y=lan),colour = 'red',alpha=0.7)
}
# 获取地震的日期
time <- sort(unique(data$date))
# 生成并保存动画
saveMovie(for( i in time) print(plotfunc(i)))