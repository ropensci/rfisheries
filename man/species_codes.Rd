\name{species_codes}
\alias{species_codes}
\title{Download species data including three-letter ASFIS species code. Returns a data frame with scientific_name, taxocode, a3_code, isscaap, and English name. The a3_code is required by \code{landings} to return species specific landing data.}
\usage{
  species_codes(curl = getCurlHandle(), ...)
}
\arguments{
  \item{curl}{Pass curl handle when calling function
  recursively.}

  \item{...}{additional optional parameters}
}
\value{
  data.frame
}
\description{
  Download species data including three-letter ASFIS
  species code. Returns a data frame with scientific_name,
  taxocode, a3_code, isscaap, and English name. The a3_code
  is required by \code{landings} to return species specific
  landing data.
}
\examples{
\dontrun{
species_codes()
}
}

