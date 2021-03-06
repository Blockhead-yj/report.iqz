% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RPT_detail_pred.R
\name{RPT_detail_pred}
\alias{RPT_detail_pred}
\title{Report the prediction and potential judgment in detail}
\usage{
RPT_detail_pred(data_wider, threshold)
}
\arguments{
\item{data_wider}{Data.frame, which each row contains all the observations of a single person}

\item{threshold}{Numerical, missing proportion threshold above which the user will be dropped}
}
\value{
A \link[tibble:tibble-package]{tibble}/table
}
\description{
This function is used to make a detailed table of academic potential
prediction and potential judgment.
}
