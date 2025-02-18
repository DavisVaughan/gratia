% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/smooth-estimates.R
\name{draw.smooth_estimates}
\alias{draw.smooth_estimates}
\title{Plot the result of a call to \code{smooth_estimates()}}
\usage{
\method{draw}{smooth_estimates}(
  object,
  constant = NULL,
  fun = NULL,
  contour = TRUE,
  contour_col = "black",
  n_contour = NULL,
  ci_alpha = 0.2,
  ci_col = "black",
  smooth_col = "black",
  resid_col = "steelblue3",
  partial_match = FALSE,
  discrete_colour = NULL,
  discrete_fill = NULL,
  continuous_colour = NULL,
  continuous_fill = NULL,
  angle = NULL,
  ylim = NULL,
  projection = "orthographic",
  orientation = NULL,
  ...
)
}
\arguments{
\item{object}{a fitted GAM, the result of a call to \code{\link[mgcv:gam]{mgcv::gam()}}.}

\item{constant}{numeric; a constant to add to the estimated values of the
smooth. \code{constant}, if supplied, will be added to the estimated value
before the confidence band is computed.}

\item{fun}{function; a function that will be applied to the estimated values
and confidence interval before plotting. Can be a function or the name of a
function. Function \code{fun} will be applied after adding any \code{constant}, if
provided.}

\item{contour}{logical; should contours be draw on the plot using
\code{\link[ggplot2:geom_contour]{ggplot2::geom_contour()}}.}

\item{contour_col}{colour specification for contour lines.}

\item{n_contour}{numeric; the number of contour bins. Will result in
\code{n_contour - 1} contour lines being drawn. See \code{\link[ggplot2:geom_contour]{ggplot2::geom_contour()}}.}

\item{ci_alpha}{numeric; alpha transparency for confidence or simultaneous
interval.}

\item{ci_col}{colour specification for the confidence/credible intervals
band. Affects the fill of the interval.}

\item{smooth_col}{colour specification for the smooth line.}

\item{resid_col}{colour specification for the partial residuals.}

\item{partial_match}{logical; should smooths be selected by partial matches
with \code{select}? If \code{TRUE}, \code{select} can only be a single string to match
against.}

\item{discrete_colour, discrete_fill, continuous_colour, continuous_fill}{suitable scales for the types of data.}

\item{angle}{numeric; the angle at which the x axis tick labels are to be
drawn passed to the \code{angle} argument of \code{\link[ggplot2:guide_axis]{ggplot2::guide_axis()}}.}

\item{ylim}{numeric; vector of y axis limits to use all \emph{all} panels drawn.}

\item{projection}{character; projection to use, see \code{\link[ggplot2:coord_map]{ggplot2::coord_map()}}
for details.}

\item{orientation}{an optional vector \code{c(latitude, longitude, rotation)}
which describes where the "North Pole" should be when computing the
projection. The third value is a clockwise rotation (in degrees), which
defaults to the midrange of the longitude coordinates in the data. The
default values for \code{orientation} therefore are
`c(20, 0, mean(range(longitude))))`` if this is not specified by the user.
See links in \code{\link[ggplot2:coord_map]{ggplot2::coord_map()}} for more information.}

\item{...}{additional arguments passed to \code{\link[patchwork:wrap_plots]{patchwork::wrap_plots()}}.}
}
\description{
Plot the result of a call to \code{smooth_estimates()}
}
\examples{
load_mgcv()
# example data
df <- data_sim("eg1", seed = 21)
# fit GAM
m <- gam(y ~ s(x0) + s(x1) + s(x2) + s(x3), data = df, method = "REML")
# plot all of the estimated smooths
sm <- smooth_estimates(m)
draw(sm)
# evaluate smooth of `x2`
sm <- smooth_estimates(m, smooth = "s(x2)")
# plot it
draw(sm)

# customising some plot elements
draw(sm, ci_col = "steelblue", smooth_col = "forestgreen", ci_alpha = 0.3)

# Add a constant to the plotted smooth
draw(sm, constant = coef(m)[1])
}
