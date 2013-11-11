#' Download species data including three-letter ASFIS species code.
#'
#' Returns a data frame with scientific_name, taxocode, a3_code, isscaap, and English name. The a3_code is required by \code{\link{landings}} to return species specific landing data.
#'
#' @param  curl Pass curl handle when calling function recursively.
#' @param  progress Progress bar. Default is text. set to \code{none} to suppress
#' @param  ... additional optional parameters
#' @importFrom RCurl getForm getCurlHandle
#' @importFrom RJSONIO fromJSON
#' @export
#' @return data.frame
#' @examples \dontrun{
#' species_codes()
#'}
species_codes <- function(curl = getCurlHandle(), progress  = "text", ...) {
    url <- "http://openfisheries.org/api/landings/species"
    species <- suppressWarnings(getForm(url, .opts = list(...), curl = curl))
    species <- fromJSON(I(species))
    species_without_null <- lapply(species, function(x) {
    x[["isscaap"]] <- ifelse(is.null(x[["isscaap"]]), NA, x[["isscaap"]])
    return(x)
})
    species_list <- as.data.frame(do.call(rbind, species_without_null))
    return(species_list)
} 






