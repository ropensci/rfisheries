\name{fish_plot}
\alias{fish_plot}
\title{Plots data for an rfisheries object}
\usage{
  fish_plot(x, ...)
}
\arguments{
  \item{x}{A landings dataset belonging to either a species
  or a country.}

  \item{...}{additional arguments}
}
\description{
  Plots data for an rfisheries object
}
\examples{
\dontrun{
fish_plot(landings(country = 'CAN'))
}
}

