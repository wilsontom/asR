# asR

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) [![R-CMD-check](https://github.com/wilsontom/asR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/wilsontom/asR/actions/workflows/R-CMD-check.yaml) [![codecov](https://codecov.io/gh/wilsontom/asR/branch/main/graph/badge.svg?token=W7hZhHcwPp)](https://codecov.io/gh/wilsontom/asR) ![License](https://img.shields.io/badge/license-GNU%20GPL%20v3.0-blue.svg "GNU GPL v3.0")


## Getting Started

`asR` can be installed directly from GitHub using the `remotes` package. 

```r
remotes::install_github('wilsontom/asR')
```

The package contains three separate functions, all of which using the filepath of a `.ASR` file as it's input.

```r
library(asR)

test_file <- system.file('extdata/test_data.ASR', package = 'asR')


asr_chroms <- get_chromatograms(test_file)



asr_peak_tables <- get_peak_tables(test_file)



asr_sample_info <- get_sample_info(test_file)


```

## Disclaimer

This package has been developed with the intention of parsing .ASR files but has only been tested with .ASR files from an Hitachi LA8080 Amino Acid Analyser operating with Aglient's OpenLab CDS.
