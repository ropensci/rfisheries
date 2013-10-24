![](https://travis-ci.org/ropensci/rfisheries.png)

# rfisheries #
![](https://raw.github.com/ropensci/rfisheries/master/betaLogo.png)

This package provides programmatic access to the [openfisheries](http://openfisheries.org/) [API](http://openfisheries.org/api-info).
Open Fisheries is a platform that aggregates global fishery data and currently offers global fish capture landings from 1950 onwards (more data coming soon). Read more about that effort [here](http://openfisheries.org/about).

# Installing #
To install, you'll need the `devtools` package first.

```coffee
install.packages('devtools')
library(devtools)
install_github('rfisheries', 'ropensci')
```

# Usage #
Package currently provides three basic functions. Landings data can be obtained by calling `landings()`

```coffee
library(rfisheries)
landings()
   catch year
1 19234925 1950
2 21691884 1951
3 23653027 1952
4 24076599 1953
5 25988306 1954
6 27510779 1955
...

# To get country specific data, provide a iso3c country code

landings(country = "USA")
    catch year
1 2629961 1950
2 2452312 1951
3 2472565 1952
4 2534099 1953
5 2596039 1954
6 2621021 1955
...

# To get species specific landings, provide the correct a3 code for the required species.

landings(species = "SKJ")
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

```coffee
species_codes()
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
country_codes()
         country iso3c
1    Afghanistan   AFG
2        Albania   ALB
3        Algeria   DZA
4 American Samoa   ASM
5        Andorra   AND
6         Angola   AGO
```

## Example: Compare landings from multiple countries

```coffee
library(plyr)
library(rfisheries)
countries <- country_codes()
# let's take a small subset, say 5 random countries
c_list <- countries[sample(nrow(countries), 5),]$iso3c
# and grab landings data for these countries
results <- ldply(c_list, function(x) {
    df <- landings(country = x)
    df$country  <-  x
    df
}, .progress = 'text')
```

You can easily compare these results
```coffee
library(ggplot2)
ggplot(results, aes(year, catch, group = country, color = country)) + geom_line()
```
![](https://raw.github.com/ropensci/rfisheries/master/multiple_countries.png)

Similarly you can get landings data for multiple species. As the API evolves, we'll update the package and get it to [CRAN](http://cran.r-project.org/) at some point.

[Please report any issues or bugs](https://github.com/ropensci/rfisheries/issues).

License: CC0

This package is part of the [rOpenSci](http://ropensci.org/packages) project.


[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)