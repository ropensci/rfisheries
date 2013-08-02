# tests for alm fxn in alm
context("rfisheries")

test_that("Main functions return data.frames", {
cc <- country_codes()
sp <- species_codes()
# landings by country
landings <- landings(country = 'CAN')
# landings by species
lbysp <- landings(species = "SKJ")
    expect_that(cc, is_a("data.frame"))
    expect_that(sp, is_a("data.frame"))
    expect_that(landings, is_a("data.frame"))
    expect_that(lbysp, is_a("data.frame"))
})

