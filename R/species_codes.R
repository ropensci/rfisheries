#' Download species data including three-letter ASFIS species code.
#'
#' Returns a data frame with scientific_name, taxocode, a3_code, isscaap, and English name. The a3_code is required by \code{\link{landings}} to return species specific landing data.
#'
#' @param foptions additional optional parameters
#' @export
#' @importFrom httr GET content stop_for_status
#' @importFrom data.table rbindlist
#' @export
#' @return data.frame
#' @examples \dontrun{
#' species_list <- species_codes()
#'}
species_codes <- function(foptions = list()) {
    url <- "http://openfisheries.org/api/landings/species"
    species <- GET(url, foptions)
    stop_for_status(species)
    species_data <- content(species)
    species_data <- llply(species_data, spfillnull)
    species_data_frame <- data.frame(rbindlist(species_data))
    species_data_frame
} 

# Internal function used inside species_code2
#' @noRd
spfillnull <- function(x) {
  x[["isscaap"]] <- ifelse(is.null(x[["isscaap"]]), NA, x[["isscaap"]])
 as.list(x, stringsAsFactors = FALSE)
}

# Notes. Last version of species_codes was returning a data.frame but each 
# column was a list rather than a vector.
# In fixing the function, I used data.table's rbindlist and made the fn even faster.
# See benchmark below.
# Also replaced Rcurl with httr. Another #win!
# system.time(z <- species_codes())
 #   user  system elapsed 
 # 14.205   0.530  21.462 
# system.time(x <- rfisheries::species_codes())
  #  user  system elapsed 
  # 0.489   0.059   8.144 

