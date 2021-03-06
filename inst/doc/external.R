## ----setup, include=FALSE------------------------------------------------
library(rstan)
knitr::opts_chunk$set(
  echo = TRUE, eval = FALSE
)

## ---- eval = TRUE--------------------------------------------------------
mc <- 
'
functions { int fib(int n); }
model {} // use the fib() function somehow
'
try(stan_model(model_code = mc, model_name = "parser_error"), silent = TRUE)

## ------------------------------------------------------------------------
#  stan_model(model_code = mc, model_name = "external", allow_undefined = TRUE,
#             includes = paste0('\n#include "',
#                               file.path(getwd(), 'fib.hpp'), '"\n'))

## ---- echo = FALSE, eval = TRUE, comment = NA----------------------------
cat(readLines(system.file("include", "src", "stan", "model", "model_header.hpp", 
                          package = "StanHeaders")), sep = "\n")

## ---- eval = TRUE--------------------------------------------------------
mc <- 
'
functions { real besselK(real v, real z); }
model {} // use the besselK() function somehow
'

## ------------------------------------------------------------------------
#  stan_model(model_code = mc, model_name = "external", allow_undefined = TRUE,
#             includes = paste0('\n#include "',
#                               file.path(getwd(), 'besselK.hpp'), '"\n'))

## ---- eval = TRUE--------------------------------------------------------
try(readLines(stanc(model_code = mc, allow_undefined = TRUE)$cppcode))

