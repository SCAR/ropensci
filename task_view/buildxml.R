if(!require("stringr")) install.packages("stringr", repos="https://cran.rstudio.com")
template <- readLines("Antarctic.ctv")
pattern <- "pkg>[[:alnum:]]+[[:alnum:].]*[[:alnum:]]+"
out <- paste0(template, collapse = " ")
pkgs <- stringr::str_extract_all(out, pattern)[[1]]
pkgs <- unique(gsub("^pkg>", "", pkgs))
priority <- c()
pkgs <- pkgs[ !pkgs %in% priority] # remove priority packages
pkgs <- lapply(as.list(sort(pkgs)), function(x) list(package=x))
output <-
c(paste0('<CRANTaskView>
  <name>Antarctic</name>
  <topic>Antarctic and Southern Ocean Science</topic>
  <maintainer email="ben.raymond@aad.gov.au">Ben Raymond</maintainer>
  <version>',Sys.Date(),'</version>'),
  '  <info>',
  paste0("    ",template),
  '  </info>',
  '  <packagelist>',
  # list priority packages explicitly
  ## uncommment this line once there is somthing in "priority" list, above
  ##paste0('    <pkg priority="core">', priority, '</pkg>', collapse = "\n"),
  # add all other packages from `pkgs`
  paste0('    <pkg>', unlist(unname(pkgs)), '</pkg>', collapse = "\n"),
  '  </packagelist>',
  '  <links>',
  '    <a href="https://github.com/ropensci/taxonomy">taxonomy task view</a>',
  '    <a href="https://cran.r-project.org/web/views/Spatial.html">spatial task view</a>',
  '    <a href="https://cloud.r-project.org/web/views/SpatioTemporal.html">spatiotemporal task view</a>',
  '  </links>',
  '</CRANTaskView>')

writeLines(output, "Antarctic.ctv")
