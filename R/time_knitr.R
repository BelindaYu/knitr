## from: https://rstudio-pubs-static.s3.amazonaws.com/125563_957ff55b072a4adea7747e7d2d14d259.html
timer <- function(before, options, envir) {
  if (before) {
    # <<- assigns in parent environment so we access it on next call
    .knitr.timer.start <<- Sys.time()
  } else {
    .knitr.timer.end <- Sys.time()
    d <- data.frame(chunk=options$label, start=.knitr.timer.start, end=.knitr.timer.end)
    d$seconds <- difftime(d$end, d$start, units='secs')
    if (!exists(".knitr.timer")) {
      .knitr.timer <<- d
    } else {
      .knitr.timer <<- rbind(.knitr.timer, d)
    }
  }
}

## to be deleted
timings <- function(before, options, envir) {
  if (!before) {
    .knitr.timer <- within(.knitr.timer, seconds <- round(seconds, 1))
    heading <- "\n\n**Chunk execution times**\n\n"
    table <- paste(kable(.knitr.timer), "\n")
    return(c(heading, table))
  }
}
