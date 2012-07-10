require(PBSmapping)
data(nepacLL,surveyData)
plotMap(nepacLL, xlim=c(-131.8,-127.2), ylim=c(50.5,52.7),
        col="gainsboro",plt=c(.08,.99,.08,.99))
surveyData$Z <- surveyData$catch
addBubbles(surveyData, symbol.bg=rgb(.9,.5,0,.6),
           legend.type="nested", symbol.zero="+", col="grey")