#' Download full list of ISO-3166 alpha 3 country code.
#'
#' Function returns a data frame with country name and  \code{iso3c} code which is required by the \code{\link{landings}} function to return country specific data
#'
#' @param  foptions additional curl options
#' @export
#' @return data.frame
#' @importFrom httr GET content stop_for_status
#' @importFrom data.table rbindlist
#' @examples \dontrun{
#' country_codes()
#'}
country_codes <- function(foptions = list()) {
    url <- "http://openfisheries.org/api/landings/countries"
    countries_call <- GET(url, foptions)
    stop_for_status(countries_call)
    countries<- content(countries_call)
    countries <- data.frame(rbindlist(countries))
    return(countries)
}
