#' a function to query landings data from openfisheries API
#' @param api_key the key assigned from openfisheries.org
#' @param 
#' @details constructs the API query url as:
#' http://openfisheries.org/api/landings.php?api_key=KEY&iso3c=USA
#' @import RJSONIO
#' @import RCurl ( >= 1.6)
#' @examples \dontrun{
#' # Can add this line to your .Rprofile file to store your secret key
#' options(openfisheries = "carl2011")
#' ## call the queries
#' global <- openfisheries() 
#' usa <- openfisheries(country = "USA")
#' ## a simple plot
#' plot(global$year, global$data, type = "l")
#' lines(usa$year, usa$data, col = 2)
#' ## A nicer ggplot  
#' require(ggplot2)
#' dat <- data.frame(year = global$year, global = as.numeric(global$data),
#' usa=as.numeric(usa$data)) 
#' dat2 <- melt(dat, id="year")
#' ggplot(dat2, aes(year, value, fill=variable)) + geom_area() 
#' }
openfisheries <- function(country=NA, api_key=getOption("openfisheries", 
                          stop("Need an api key for openfisheries.org")),
                          curl=getCurlHandle(), ...){
  args <- list(api_key = api_key)
  url <- "http://openfisheries.org/api/landings.php"
  if(!is.na(country))
    args$iso3c <- as.character(country)
  tt <- getForm(url, .params = args, .opts = list(...), curl=curl)
  fromJSON(I(tt))
}

