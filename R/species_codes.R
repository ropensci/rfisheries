#' Download species data including three-letter ASFIS species code.
#'
#' Returns a data frame with scientific_name, taxocode, a3_code, isscaap, and English name. The a3_code is required by \code{\link{landings}} to return species specific landing data.
#'
#' @param  curl Pass curl handle when calling function recursively.
#' @param  ... additional optional parameters
#' @export
#' @return data.frame
#' @examples \dontrun{
#' species_codes()
#'}
species_codes <- function(curl = getCurlHandle(), ...) {
    url <- "http://openfisheries.org/api/landings/species"
    species <- suppressWarnings(getForm(url, .opts = list(...), curl = curl))
    species <- fromJSON(I(species))
    species_list <- ldply(species, function(x) {
        if (x[4] == "NULL") 
            x[4] <- "NA"
        data.frame(x)
    }, .progress = "text")
    return(species_list)
} 
