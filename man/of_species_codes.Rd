\name{of_species_codes}
\alias{of_species_codes}
\title{Download species data including three-letter ASFIS species code.}
\usage{
of_species_codes(foptions = list())
}
\arguments{
  \item{foptions}{additional optional parameters}
}
\value{
data.frame
}
\description{
Returns a data frame with scientific_name, taxocode,
a3_code, isscaap, and English name. The a3_code is required
by \code{\link{landings}} to return species specific
landing data.
}
\examples{
\dontrun{
of_species_list <- of_species_codes()
}
}

