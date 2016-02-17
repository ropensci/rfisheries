
Linux: ![travis](https://travis-ci.org/ropensci/rfisheries.png)  
Windows: [![Build status](https://ci.appveyor.com/api/projects/status/agi7g487s4g53u4p)](https://ci.appveyor.com/project/karthik/rfisheries)  
![CRAN_downloads](http://cranlogs.r-pkg.org/badges/rfisheries)  


# rfisheries #
![beta logo](https://raw.github.com/ropensci/rfisheries/master/betaLogo.png)

This package provides programmatic access to the [openfisheries](http://openfisheries.org/) [API](http://openfisheries.org/api-info).
Open Fisheries is a platform that aggregates global fishery data and currently offers global fish capture landings from 1950 onwards (more data coming soon). Read more about that effort [here](http://openfisheries.org/about).

# Installing #

```r
install.packages("rfisheries")
```

or grab the development version. To install this version you'll need the `devtools` package first.


```r
# install.packages('devtools')
devtools::install_github('ropensci/rfisheries')
```

# Usage #
Package currently provides three basic functions. Landings data can be obtained by calling `landings()`

```r
library(rfisheries)
of_landings()
   catch year
1 19234925 1950
2 21691884 1951
3 23653027 1952
4 24076599 1953
5 25988306 1954
6 27510779 1955
...

# To get country specific data, provide a iso3c country code

of_landings(country = "USA")
    catch year
1 2629961 1950
2 2452312 1951
3 2472565 1952
4 2534099 1953
5 2596039 1954
6 2621021 1955
...

# To get species specific landings, provide the correct a3 code for the required species.

of_landings(species = "SKJ")
   catch year
1 162750 1950
2 185848 1951
3 157411 1952
4 164629 1953
5 210702 1954
6 189223 1955
...
```

If you don't have know the correct species or country codes, you can get a complete list with the following two functions.

```r
of_species_codes()
         scientific_name   taxocode a3_code isscaap
1     Petromyzon marinus 1020100101     LAU      25
2   Lampetra fluviatilis 1020100201     LAR      25
3    Lampetra tridentata 1020100202     LAO      25
4 Ichthyomyzon unicuspis 1020100401     LAY      25
5    Eudontomyzon mariae 1020100501     LAF      25
6      Geotria australis 1020100701     LAE      25
             english_name
1             Sea lamprey
2           River lamprey
3         Pacific lamprey
4          Silver lamprey
5 Ukrainian brook lamprey
6         Pouched lamprey
...

# Similarly you can get a full list of country codes
of_country_codes()
         country iso3c
1    Afghanistan   AFG
2        Albania   ALB
3        Algeria   DZA
4 American Samoa   ASM
5        Andorra   AND
6         Angola   AGO
```

## Example: Compare landings from multiple countries

```r
library(plyr)
library(rfisheries)
countries <- of_country_codes()
# let's take a small subset, say 5 random countries
c_list <- countries[sample(nrow(countries), 5),]$iso3c
# and grab landings data for these countries
results <- ldply(c_list, function(x) {
    df <- of_landings(country = x)
    df$country  <-  x
    df
}, .progress = 'text')
```

You can easily compare these results
```r
library(ggplot2)
ggplot(results, aes(year, catch, group = country, color = country)) + geom_line()
```
![multiple countries](https://raw.github.com/ropensci/rfisheries/master/multiple_countries.png)

Similarly you can get landings data for multiple species. As the API evolves, we'll update the package and get it to [CRAN](http://cran.r-project.org/) at some point.


## Creative interactive charts

Using the [rCharts library](http://ramnathv.github.io/rCharts/), it's easy to create interactive plots. Here's a quick example.

```r
library(rfisheries)
library(rCharts)
cod <- of_landings(species = "COD")
cod$date <- paste0(cod$year, "-01", "-01")
cod_plot <- mPlot(x = "date", y = "catch", type = "Line", data = cod)
cod_plot$set(pointSize = 0, lineWidth = 4)
cod_plot
```
[Please report any issues or bugs](https://github.com/ropensci/rfisheries/issues).

License: MIT

This package is part of the [rOpenSci](http://ropensci.org/packages) project.

To cite package ‘rfisheries’ in publications use:

```r
  Karthik Ram, Carl Boettiger and Andrew Dyck (2013). rfisheries: R
  interface for fisheries data. R package version 0.1.
  http://CRAN.R-project.org/package=rfisheries

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {rfisheries: R interface for fisheries data},
    author = {Karthik Ram and Carl Boettiger and Andrew Dyck},
    year = {2013},
    note = {R package version 0.1},
    url = {http://CRAN.R-project.org/package=rfisheries},
  }
```
[![footer](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)