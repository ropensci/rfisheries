#' Plots data for an rfisheries object
#' 
#'@importFrom ggplot2 ggplot
#' @param x A landings dataset belonging to either a species or a country.
#' @param ... additional arguments
#' @export
#' @examples \dontrun{
#' fish_plot(landings(country = 'CAN'))
#'}
fish_plot <- function(x, ...) {

# Both datasets really should have 3 columns.
# Otherwise something is wrong
stopifnot(class(x) == "data.frame")
stopifnot(ncol(x) == 3)   

# Allows to check which type of landings data we're working with
species_dataset <- c("catch","year", "species")
country_dataset <- c("catch","year", "country")

# Update ggplot theme for pltos
old <- theme_get()


theme_update(panel.background = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), panel.border = element_blank(),
        axis.line = element_line(colour = "black"))

if(identical(species_dataset, names(x))) {
if(is.null(title)) {    
    title <- paste0("Landings for ", unique(x$species))    
}
fish_plot <- ggplot(x, aes(year, catch)) + 
geom_line(color = "steelblue", size = .9) + 
labs(x= "Year", y= "Catch (in tonnes)") + 
ggtitle(title)
}

if(identical(country_dataset, names(x))) {
    if(is.null(title)) {    
    title <- paste0("Landings for ", unique(x$country))    
    }
fish_plot <-  ggplot(x, aes(year, catch)) + 
geom_line(color = "steelblue", size = .9) + 
labs(x= "Year", y= "Catch (in tonnes)") + 
ggtitle(title)
}
# Add a theme
theme_set(old)
# Return plot object
return(fish_plot)
}

# [Todos]
# Not a method for time being because we'd have to define a new class. @method plot rfisheries
# Not defining a method for now. @S3method plot rfisheries