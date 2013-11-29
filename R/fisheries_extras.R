#' Plots data for an rfisheries object
#' 
#'@importFrom ggplot2 ggplot theme_get theme_update ggtitle geom_line labs theme_set element_line element_blank aes
#' @param x A landings dataset belonging to either a species or a country.
#' @param linecolor Default line color is steelblue
#' @param linesize Default line size is 0.9
#' @param title Plot title. Title is generated based on species or country code. Specify one here only if you need something else.
#' @param ... additional arguments
#' @export
#' @examples \dontrun{
#' fish_plot(landings(country = 'CAN'))
#'}
fish_plot <- function(x, linecolor = "steelblue", linesize = 0.9, title = NULL, ...) {

year <- NA 
catch <- NA

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
    data(species_code_data)
    english_name <- species_code_data[grep(unique(x$species),species_code_data),]$english_name
    title <- paste0("Landings for ", english_name, "(", unique(x$species), ")")    
}
fish_plot <- ggplot(x, aes(year, catch)) + 
geom_line(color = linecolor, size = linesize) + 
labs(x= "Year", y = "Catch (in tonnes)") + 
ggtitle(title)
}

if(identical(country_dataset, names(x))) {
    if(is.null(title)) {
        # [Todo]: Add species or country name into the title.
    title <- paste0("Landings for ", unique(x$country))    
    }
fish_plot <-  ggplot(x, aes(year, catch)) + 
geom_line(color = linecolor, size = linesize) + 
labs(x = "Year", y = "Catch (in tonnes)") + 
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
