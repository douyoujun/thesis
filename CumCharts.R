#The following packages need to be installed
require(FinancialInstrument)
require(googleVis)
require(PerformanceAnalytics)

#define a function to calculate the cumulative growth given a set of returns
cumulative_growth <- function(x){
  #x must be an xts object of returns
  x[1,] = 0
  temp = cumprod(1 + x)
  return(temp)
}

# #define a function to transform an xts object to a data.frame
# xts_to_df = function(x){
#   TODO
# }

#create a list of symbols
symbols = c("XLY", "XLP", "XLE")#, "XLF", "XLV", "XLI", "XLK", "XLB", "XLU")

#creates a list of objects that will be filled later
ret_symbols = paste("ret", symbols, sep = "_")
cg_symbols = paste("cg", symbols, sep="_")

#Set up instruments using the Financial Instruments package
currency("USD")
for(symbol in symbols){
  stock(symbol, currency = "USD",multiplier = 1)
}

#Load ETF Data from yahoo
getSymbols(symbols, src='yahoo', index.class=c("POSIXt","POSIXct"), from='2000-01-01')

#Data is downloaded as daily data
#Convert to monthly
for(symbol in symbols) {
  x <- get(symbol)
  x <- to.monthly(x, indexAt = 'lastof', drop.time = TRUE)
  indexFormat(x) <- '%Y-%m-%d'
  colnames(x) <- gsub("x", symbol, colnames(x))
  assign(symbol, x)
}

#Loop to create new xts objects with just the returns
for (symbol in symbols){
  x <- get(symbol)
  x1 <- ROC(Ad(x), n=1, type="continuous", na.pad=TRUE)
  colnames(x1)<-gsub("x", symbol, colnames(x1))
  assign(paste("ret", symbol, sep = "_"),x1)
  x2 <- cumulative_growth(x1)
  assign(paste("cg", symbol, sep = "_"),x2)
}

#merges all of the objects in 'ret_symbols' into one object named 'ret' for multiple symbols
ret = do.call(merge, lapply(ret_symbols, get))

#merges all of the objects in 'cg_symbols' into one object named 'growth'
#this is an xts object of cumulative growth of $1 for multiple symbols
wealth_index = do.call(merge, lapply(cg_symbols, get))

#convert the wealth_index to a data.frame for use with googleVis
new_df = as.data.frame(wealth_index)
Date = index(wealth_index)
wi_df = data.frame(Date, new_df)

m = gvisLineChart(data = wi_df, xvar = "Date", yvar = c("XLY.Adjusted", "XLP.Adjusted", "XLE.Adjusted"), options = list(title = "Cumulative Growth of $1"))
plot(m)

#wi_chart = chart.TimeSeries(wealth_index[,1:ncol(wealth_index)], main = "Cumulaltive Growth of $1")
