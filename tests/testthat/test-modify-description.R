test_that("modify description will delete a remotes field if requested", {
  # description should still work if no remotes field present
  d <- desc::desc(file = "./testdata/simple.DESCRIPTION")
  expect_equal(as.character(d$get("Package")), "test")
  expect_equal(d$get_remotes(), character(0))
  output_file <- tempfile()
  modify_desc(d, list(Repository = "test"), output_file) 
  expect_snapshot_file(output_file, "simple.DESCRIPTION")
})

test_that("modify description will delete a remotes field if requested", {
  # description should still work if no remotes field present
  d <- desc::desc(file = "./testdata/remotes.DESCRIPTION")
  expect_equal(as.character(d$get("Package")), "test")
  expect_equal(d$get_remotes(), "rstudio/gt#4")
  output_file <- tempfile()
  modify_desc(d, list(), output_file, remove_remotes = TRUE) 
  expect_snapshot_file(output_file, "remove-remote.DESCRIPTION")
  # description should remove the remotes field if it was present and everything
  # else should be unchanged
})
