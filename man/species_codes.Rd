\name{species_codes}
\alias{species_codes}
\title{Download species data including three-letter ASFIS species code.}
\usage{
species_codes(foptions = list())
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
species_list <- species_codes()
}
}

