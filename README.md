
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cranq

(Pronounced either like “cran queue” or “crank”, I don’t mind.)

The goal of cranq is to provide a quick way to check the status of
packages in CRAN’s incoming package queue.

This can be especially useful if you’re releasing a package and want to
check on the status of your submission.

Having said that, most people will be better off using the [R-Hub CRAN
Incoming
Dashboard](https://r-hub.github.io/cransays/articles/dashboard.html)
instead of this package.

## Installation

You can install the development version of cranq like this:

``` r
remotes::install_github("sellorm/cranq")
```

## A quick note on usage

This package scrapes the web pages for the [CRAN incoming
queue](https://cran.r-project.org/incoming/) and as such relies on the
fact that this is easily available, public information.

Those pages exist at the discretion of the CRAN team. They’re a
privilege, not a right. So just like you wouldn’t load up all those
pages in your web browser and keep mashing the reload button, please
don’t repeatedly execute these functions in a quick-fire fashion.

Basically, don’t be an idiot. Thanks!

## Usage

There are basically two things cranq can do for you. You can view the
incoming queue or you can search for a package within the queue.

To show all packages in the incoming queue:

``` r
library(cranq)
incoming()
#> # A tibble: 30 × 4
#>    name                         modified         size  queue  
#>    <chr>                        <chr>            <chr> <chr>  
#>  1 FCO_0.7.1.tar.gz             2022-02-09 18:17 155K  inspect
#>  2 FastJM_1.1.1.tar.gz          2022-02-09 18:03 137K  inspect
#>  3 bizicount_1.0.0.tar.gz       2022-02-09 19:13 42K   inspect
#>  4 iq_1.9.2.tar.gz              2022-02-04 19:00 1.0M  inspect
#>  5 musclesyneRgies_1.1.1.tar.gz 2022-02-09 18:24 1.2M  inspect
#>  6 rankFD_0.1.1.tar.gz          2022-01-25 20:04 36K   inspect
#>  7 Certara.R_1.0.0.tar.gz       2022-02-09 20:32 6.1K  newbies
#>  8 DBpower_0.1.0.tar.gz         2022-02-09 18:44 25K   newbies
#>  9 OlinkAnalyze_3.0.0.tar.gz    2022-02-09 19:37 1.2M  newbies
#> 10 RClickhouse_0.6.1.tar.gz     2022-02-09 21:31 104K  newbies
#> # … with 20 more rows
```

To show a specific incoming stage by name:

``` r
incoming("newbies")
#> # A tibble: 9 × 4
#>   name                      modified         size  queue  
#>   <chr>                     <chr>            <chr> <chr>  
#> 1 Certara.R_1.0.0.tar.gz    2022-02-09 20:32 6.1K  newbies
#> 2 DBpower_0.1.0.tar.gz      2022-02-09 18:44 25K   newbies
#> 3 OlinkAnalyze_3.0.0.tar.gz 2022-02-09 19:37 1.2M  newbies
#> 4 RClickhouse_0.6.1.tar.gz  2022-02-09 21:31 104K  newbies
#> 5 icesConnect_1.0.0.tar.gz  2022-02-09 19:12 5.7K  newbies
#> 6 omnibus_1.1.1.tar.gz      2022-02-09 20:57 57K   newbies
#> 7 ravetools_0.0.1.tar.gz    2022-02-09 18:13 446K  newbies
#> 8 superMICE_1.0.1.tar.gz    2022-02-09 21:57 17K   newbies
#> 9 tipsae_0.0.4.tar.gz       2022-02-09 17:48 2.6M  newbies
```

To find a specific package within all the queues:

``` r
check_package("musclesyneRgies")
#> $name
#> [1] "musclesyneRgies_1.1.1.tar.gz"
#> 
#> $modified
#> [1] "2022-02-09 18:24"
#> 
#> $size
#> [1] "1.2M"
#> 
#> $queue
#> [1] "inspect"
```

Edgar Ruiz and Hadley Wickham performed some [analysis of what these
stages might mean](https://github.com/edgararuiz-zz/cran-stages).

## License

Released under the [MIT License](LICENSE.md).

Copyright (c) 2022 Mark Sellors.
