library(shinytest2)

test_that("{shinytest2} recording: grusgrus", {
  app <- AppDriver$new(variant = platform_variant(), name = "grusgrus", height = 901, 
      width = 1619)
  app$set_inputs('species_selection-species_search' = "Grus grus")
  app$click("species_selection-search_button")
  app$expect_values()
  app$expect_screenshot()
})


test_that("{shinytest2} recording: species_selectionEmpty", {
  app <- AppDriver$new(variant = platform_variant(), name = "species_selectionEmpty", 
      height = 901, width = 1619)
  app$set_inputs('species_selection-species_search' = "")
  app$click("species_selection-search_button")
  app$expect_values()
  app$expect_screenshot()
})
