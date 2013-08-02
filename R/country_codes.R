#' Download full list of ISO-3166 alpha 3 country code.
#'
#' Function returns a data frame with country name and  \code{iso3c} code which is required by the \code{\link{landings}} function to return country specific data
#'
#' @param  curl Pass curl handle when calling function recursively.
#' @param  ... additional optional parameters
#' @export
#' @return data.frame
#' @examples \dontrun{
#' country_codes()
#'}
country_codes <- function(curl = getCurlHandle(), ...) {
    url <- "http://openfisheries.org/api/landings/countries"
    countries <- suppressWarnings(getForm(url, .opts = list(...),
        curl = curl))
    countries <- ldply(fromJSON(I(countries)))
    return(countries)
}
