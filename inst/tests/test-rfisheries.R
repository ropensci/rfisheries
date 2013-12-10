# tests for alm fxn in alm
context("rfisheries")

test_that("Main functions return data.frames", {
cc <- of_country_codes()
sp <- of_species_codes()
# landings by country
landings <- of_landings(country = 'CAN')
# landings by species
lbysp <- of_landings(species = "SKJ")
    expect_that(cc, is_a("data.frame"))
    expect_that(sp, is_a("data.frame"))
    expect_that(landings, is_a("data.frame"))
    expect_that(lbysp, is_a("data.frame"))
    expect_that(of_landings(species = "foo"), throws_error())
    expect_that(of_landings(country = "foo"), throws_error())
})

