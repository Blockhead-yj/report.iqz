% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/step_lm.R
\name{step_lm}
\alias{step_lm}
\title{Select predictor games by step regression}
\usage{
step_lm(data_wider, formula, n_tasks = 5, trace = FALSE, ...)
}
\arguments{
\item{data_wider}{Data.frame, which each row contains all the observations of a single person}

\item{formula}{Formula, indicate which variables should be included in model}

\item{n_tasks, }{Numerical, the least number of tasks that a step method should be used}

\item{...}{Other arguments used in stats::step function}
}
\value{
A lm object
}
\description{
Usually users will have lots of iquizoo games test at once,
however it is bad idea to put all the games into a model to predict academic
score, which might cause the problem of overfitting or a decline of adjust r squared.
So we choose a subset of iquizoo games to be placed into the model by step regression.
}
