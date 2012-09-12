Interactive charts and slides with R, googleVis and knitr
========================================
  ```{r results='asis', echo=FALSE, message=FALSE, tidy=FALSE}
library(googleVis)
G <- gvisGeoChart(Exports, "Country", "Profit", 
                  options=list(width=250, height=120), chartid="c1")

T <- gvisBarChart(Exports[,1:2], yvar="Profit", xvar="Country",                  
                  options=list(width=250, height=260, 
                               legend='none'), chartid="c2")

GT <- gvisMerge(G,T, horizontal=FALSE, chartid="gt") 

## Tree map

M <- gvisTreeMap(Regions,  "Region", "Parent", "Val", "Fac",
                 options=list(width=400, height=380,
                              fontSize=16,
                              minColor='#EDF8FB',
                              midColor='#66C2A4',
                              maxColor='#006D2C',
                              headerHeight=20,
                              fontColor='black',
                              showScale=TRUE), chartid="c3")

GTM <- gvisMerge(GT, M, horizontal=TRUE,
                 tableOptions="cellspacing=5", chartid="gtm")

print(GTM, 'chart')
```
[Markus Gesmann](https://plus.google.com/118201313972528070577/posts), [Cambridge R user group](http://www.cambr.org.uk/) meeting, 29 May 2012

# Agenda
* Motivation
* Introduction to googleVis
* Examples with googleVis
* How I created this talk with RStudio, knitr, pandoc and slidy

# Motivation
<iframe width="420" height="315" src="http://www.youtube.com/embed/hVimVzgtD6w" frameborder="0" allowfullscreen></iframe>
  
  * In 2006 Hans Rosling gave an inspiring talk at TED 
* He challenged the views and perceptions of many listeners
* To visualise his talk he used animated bubble charts, aka motion charts

# Google Chart Tools

* Google integrated the motion charts into their [Visualisation API](https://developers.google.com/chart/) in 2007
* Google Visulisation API makes it easy to create interactive charts for web pages 
* It uses JavaScript and DataTable / JSON as input
* Output is either HTML5/SVG or Flash
* Browser with internet connection required to display chart
* Please read the Google [Terms of Service](https://developers.google.com/terms/) before you start

# Introduction to googleVis
* [googleVis](http://code.google.com/p/google-motion-charts-with-r/) is a package for [R](http://www.r-poject.org/) and provides an interface between R and the [Google Chart Tools](https://developers.google.com/chart/), see *Using the Google Visualisation API with R*, 
[The R Journal, 3(2):40-44, December 2011](http://journal.r-project.org/archive/2011-2/RJournal_2011-2_Gesmann+de~Castillo.pd)
* The functions of the package allow users to visualise data with the Google Chart Tools without uploading their data to Google
* The output of googleVis functions is html code that contains the data and references to JavaScript functions hosted by Google
* To view the output a browser with an internet connection is required, the actual chart is rendered in the browser; some charts require Flash

# Key ideas of googleVis
* Create wrapper function in R which generate html files with references to Google's Chart Tools API
* Transform R data frames into [JSON](http://www.json.org/) objects with [RJSONIO](http://www.omegahat.org/RJSONIO/)

```r
cat(toJSON(CityPopularity))  ## example data from googleVis
```

```
## Error: 没有"toJSON"这个函数
```


* Display the HTML output with the R HTTP help server
* Development started in August 2010, intially to visualise data at [Lloyd's](http://www.lloyds.com/The-Market/Tools-and-Resources/Resources/Statistics-Relating-to-Lloyds/Visualisation)

# googleVis version 0.2.16 provides interfaces to 

* Motion Charts
* Annotated Time Lines
* Maps, Geo Maps and Charts
* Intensity Maps
* Tables, Gauges, Tree Maps
* Line-, Bar-, Column-, Area- and Combo Charts
* Scatter-, Bubble-, Candlestick-, Pie- and Org Charts

Run ```demo(googleVis)``` to see [examples](http://code.google.com/p/google-motion-charts-with-r/wiki/GadgetExamples) of all charts and read the [vignette](http://cran.r-project.org/web/packages/googleVis/vignettes/googleVis.pdf) for more details.

# [World Bank example](http://lamages.blogspot.co.uk/2011/09/accessing-and-plotting-world-bank-data.html)
<iframe height="550px" frameborder="no" scrolling="no"
src="http://dl.dropbox.com/u/7586336/blogger/WorldBankMotionChart.html"
width="100%">
  </iframe>
  ```{r eval=FALSE}
library(googleVis)
demo(WorldBank) 
```


# Video tutorial

<iframe width="420" height="315" src="http://www.youtube.com/embed/Z6NYQdiwTrU" frameborder="0" allowfullscreen></iframe>
  
  * Video tutorial by [Martin Hilpert](http://omnibus.uni-freiburg.de/~mh608/), [Freiburg Institute for Advanced Studies](http://www.frias.uni-freiburg.de/)
* Demonstrates how to create motion charts with googleVis


# The googleVis concept

* Charts: *'gvis' + ChartType*
  * For a motion chart we have

```r
M <- gvisMotionChart(data, idvar = "id", timevar = "date", options = list(), 
    chartid)
```

* Output of googleVis is a list of list
* Display the chart by simply plotting the output ```plot(M)```
* Plot will generate a temporay html-file and open it in a new browser window 
* Specific parts can be extracted, e.g. the chart ```M$html$chart``` or data ```M$html$chart["jsData"]```

# Embedding googleVis chart into your web page

Suppose you have an existing web page and would like to integrate the output of a googleVis function, such as ```gvisMotionChart```.

In this case you only need the chart output from ```gvisMotionChart```. So you can either copy and paste the output from the R console


```r
print(M, "chart")  ## or cat(M$html$chart)
```

into your existing html page, or write the content directly into a file


```r
print(M, "chart", file = "myfilename")
```

and process it from there.


# Simple line chart

```r
df <- data.frame(label = c("A", "B", "C"), val1 = c(0.1, 0.13, 0.14), val2 = c(23, 
    12, 32))
lc <- gvisLineChart(df)
```

```
## Error: 没有"gvisLineChart"这个函数
```

```r
print(lc, "chart")  ## So knitr includes the html output of the chart
```

```
## Error: 找不到对象'lc'
```



# Line chart with options set

```r
print(gvisLineChart(df, xvar="label", yvar=c("val1","val2"),
                    options=list(title="Hello World", legend="bottom",
                                 titleTextStyle="{color:'red', fontSize:18}",                         
                                 vAxis="{gridlines:{color:'red', count:3}}",
                                 hAxis="{title:'My Label', titleTextStyle:{color:'blue'}}",
                                 series="[{color:'green', targetAxisIndex: 0}, 
                                   {color: 'blue',targetAxisIndex:1}]",
                          vAxes="[{title:'Value 1 (%)', format:'#,###%'}, 
                                  {title:'Value 2 (\U00A3)'}]",                          
                          curveType="function", width=500, height=300                         
                    )), 'chart')
```

```
## Error: 没有"gvisLineChart"这个函数
```


# Chart countries' S&P credit rating
* Plot countries' S&P credit rating sourced from Wikipedia
* See my [blog post](http://lamages.blogspot.co.uk/2012/01/credit-rating-by-country.html) for more details

```r
## Get and prepare data
library(XML)
url <- "http://en.wikipedia.org/wiki/List_of_countries_by_credit_rating"
page <- readLines(url)
```

```
## Warning:
## 输入链结'http://en.wikipedia.org/wiki/List_of_countries_by_credit_rating'内的输入不对
```

```
## Warning:
## 读'http://en.wikipedia.org/wiki/List_of_countries_by_credit_rating'时最后一行未遂
```

```r
x <- readHTMLTable(page, which = 3)
levels(x$Rating) <- substring(levels(x$Rating), 4, nchar(levels(x$Rating)))
x$Ranking <- x$Rating
levels(x$Ranking) <- nlevels(x$Rating):1
x$Ranking <- as.character(x$Ranking)
x$Rating <- paste(x$Country, x$Rating, sep = ": ")
```


# Chart countries' S&P credit rating

```r
print(gvisGeoMap(x, "Country", "Ranking", "Rating", options = list(gvis.editor = "S&P", 
    colors = "[0x91BFDB, 0XFC8D59]")), "chart")
```

```
## Error: 没有"gvisGeoMap"这个函数
```


# Geo chart with markers

```r
require(stats)
data(quakes)
quakes$latlong <- paste(quakes$lat, quakes$long, sep = ":")
print(gvisGeoChart(quakes, locationvar = "latlong", colorvar = "depth", sizevar = "mag", 
    options = list(displayMode = "Markers", region = "009", colorAxis = "{colors:['red', 'grey']}", 
        backgroundColor = "lightblue")), "chart")
```

```
## Error: 没有"gvisGeoChart"这个函数
```


# Merging gvis-objects


```r
G <- gvisGeoChart(Exports, "Country", "Profit", options = list(width = 250, 
    height = 120))
```

```
## Error: 没有"gvisGeoChart"这个函数
```

```r
B <- gvisBarChart(Exports[, 1:2], yvar = "Profit", xvar = "Country", options = list(width = 250, 
    height = 260, legend = "none"))
```

```
## Error: 没有"gvisBarChart"这个函数
```

```r
M <- gvisMotionChart(Fruits, "Fruit", "Year", options = list(width = 400, height = 380))
```

```
## Error: 没有"gvisMotionChart"这个函数
```

```r
GBM <- gvisMerge(gvisMerge(G, B, horizontal = FALSE), M, horizontal = TRUE, 
    tableOptions = "cellspacing=5")
```

```
## Error: 没有"gvisMerge"这个函数
```

```r
print(GBM, "chart")
```

```
## Error: 找不到对象'GBM'
```



# Further case studies

* [Statistics Relating to Lloyd's](http://www.lloyds.com/The-Market/Tools-and-Resources/Resources/Statistics-Relating-to-Lloyds/Visualisation)
* [Analysis of the US domestic airline market from 1999 - 2010](http://www.cambridge.aero/_blog/main/post/US_Domestic_Airline_Market_In_Motion_1990-2010/)
   * [Linguistic analysis of the English language](http://omnibus.uni-freiburg.de/~mh608/motion.html)
   * [Exploring the Pen World Data](http://usefulr.wordpress.com/2012/04/17/quickly-explore-the-penn-world-tables-in-r/)
   * [My blog posts on googleVis](http://lamages.blogspot.co.uk/search/label/googleVis)
   
   # Other R packages
   
   * [R animation package allows to create SWF, GIF and MPEG directly](http://animation.yihui.name/)
   * [iplots: iPlots - interactive graphics for R](http://cran.r-project.org/web/packages/iplots/)
   * [Acinonyx aka iPlots eXtreme](http://rforge.net/Acinonyx/index.html)
   * [gridSVG: Export grid graphics as SVG](http://cran.r-project.org/web/packages/gridSVG/index.html)
   * [plotGoogleMaps: Plot HTML output with Google Maps API and your own data](http://cran.r-project.org/web/packages/plotGoogleMaps/)
   * [RgoogleMaps: Overlays on Google map tiles in R](http://cran.r-project.org/web/packages/RgoogleMaps/index.html)
   
   # How I created this presentation with RStudio, knitr, pandoc and slidy  
   * [knitr](http://yihui.name/knitr/) is a package by [Yihui Xie](http://yihui.name/) that brings literate programming to a new level 
   * It allows to create content really quickly, without worrying to much about layout and R formatting
   * [RStudio](http://rstudio.org) integrated knitr into its IDE, which allows to knit Rmd-files by the push of a button into markdown
   * Markdown output can be converted into serveral other file formats, such as html, with [pandoc](http://johnmacfarlane.net/pandoc/)
   * [slidy](http://www.w3.org/Talks/Tools/Slidy2/Overview.html) is one of the options to create interactive html-slides with pandoc
   
   ```
   pandoc -s -S -i -t slidy --mathjax 
   Cambridge_R_googleVis_with_knitr_and_RStudio_May_2012.md 
   -o Cambridge_R_googleVis_with_knitr_and_RStudio_May_2012.html
   ```
   
   * For more details see my recent [blog post](http://lamages.blogspot.co.uk/2012/05/interactive-reports-in-r-with-knitr-and.html) and [example file](https://gist.github.com/2704646)
   * The source file of this presentation is available on [github](https://gist.github.com/2816027)
   
   # Conclusion
   
   * Interactive charts and reports open a new way to engage with readers and users, who would find data and figures boring otherwise
   * RStudio, *knitr* and googleVis might be the way forward to create interactive analysis reports and presentations
   * The markdown language should be sufficient for most tasks to draft a report, and the integration with RStudio makes it a pleasure to work with *knitr*.
   
   # Thanks to ...
   
   * Google for making the Chart Tools available 
   * My co-author Diego de Castillo
   * [All who have provided ideas, feedback, bug reports, suggestions, etc.](http://google-motion-charts-with-r.googlecode.com/svn/trunk/THANKS)
   * [Yihui Xie](http://yihui.name/) for [knitr](http://yihui.name/knitr/)
   * JJ, Joe and Josh for [RStudio](http://rstudio.org/)
   * [Dave Raggett](http://www.w3.org/People/Raggett/) for [Slidy](http://www.w3.org/Talks/Tools/Slidy2)
   
   # Contact
   * googleVis: [http://code.google.com/p/google-motion-charts-with-r/](http://code.google.com/p/google-motion-charts-with-r/)
   * My blog: [http://lamages.blogspot.co.uk/](http://lamages.blogspot.co.uk/)
   * Email: markus dot gesmann at gmail dot com
