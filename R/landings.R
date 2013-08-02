#' Returns landings data from the openfisheries API
#'
#' The function returns aggregate landings data if no parameters are supplied. One could get country or species-specific data by specifying either one of those options. Country must be provided as the \code{iso3c} code and species must be supplied as a3_code. Supporting functions \code{country_codes} and \code{species_codes} provide that data and can be combined to return data for multiple countries or species.
#' @param country Default is \code{NA}. Download country specific data by specifying the ISO-3166 alpha 3 country code.
#' @param  species Default is \code{NA}. Download species specific data by specifying the three-letter ASFIS species code
#' @param  curl Pass curl handle when calling function recursively.
#' @param  ... additional optional parameters
#' @export
#' @return data.frame
#' @examples \dontrun{
#' landings()
#' # Landings by country
#' landings(country = 'CAN')
#' #landings by species
#' landings(species = 'SKJ')
#'}
landings <- function(country = NA, species = NA, curl = getCurlHandle(),
    ...) {
    if (!is.na(country) && !is.na(species))
        stop("Specify country or species but not both", call. = FALSE)
    if (is.na(country) && is.na(species)) {
        url <- "http://openfisheries.org/api/landings"
    } else if (!is.na(country) && is.na(species)) {
        url <- paste0("http://openfisheries.org/api/landings/countries/",
            country)
    } else {
        url <- paste0("http://openfisheries.org/api/landings/species/",
            species)
    }
    landings_data <- suppressWarnings(getForm(url, .opts = list(...),
        curl = curl))
    landings_data <- ldply(fromJSON(I(landings_data)))
    if (nrow(landings_data) == 0) {
        stop("No data found", call. = FALSE)
    } else {
        return(landings_data)
    }
}
