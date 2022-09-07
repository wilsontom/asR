test_that("asR-package", {

  test_file <- system.file('extdata/test_data.ASR', package = 'asR')

  expect_true(is.list(get_chromatograms(test_file)))
  expect_true(is.list(get_peak_table(test_file)))
  expect_true(is.data.frame(get_sample_info(test_file)))

  expect_true(length(get_chromatograms(test_file)) == length(get_peak_table(test_file)))

})
