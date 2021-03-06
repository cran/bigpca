% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bigpca.R
\name{pca.scree.plot}
\alias{pca.scree.plot}
\title{Make scree plots for any PCA}
\usage{
pca.scree.plot(eigenv, elbow = NA, printvar = TRUE, min.dim = NA,
  M = NULL, add.fit.line = FALSE, n.xax = max(30, length(eigenv)),
  linear = TRUE, verbose = FALSE, return.data = FALSE, ...)
}
\arguments{
\item{eigenv}{the vector of eigenvalues actually calculated}

\item{elbow}{the number of components which you think explain the important chunk
of the variance of the dataset, so further components are modelled as reflecting
noise or very subtle effects, e.g, often the number of components used is decided
by the 'elbow' in  a scree plot (see 'pca.scree.plot')}

\item{printvar}{logical, whether to print summary of variance calculations}

\item{min.dim}{the size of the smaller dimension of the matrix submitted to singular
value decomposition, e.g, number of samples - i.e, the max number of possible eigenvalues,
alternatively use 'M'.}

\item{M}{optional enter the original dataset 'M'; simply used to derive the dimensions,
alternatively use 'min.dim'.}

\item{add.fit.line}{logical, if there is an existing scree plot, adds the fit line from this estimate
to the plot ('pca.scree.plot' can use this option using the parameter of the same name)}

\item{n.xax}{number of components to include on the x-axis}

\item{linear}{whether to use a linear model to model the 'noise' eigenvalues; alternative
is a 1/x model with no intercept.}

\item{verbose}{logical, whether to display additional output}

\item{return.data}{logical, whether to return the percentages of variance explained for each component, or nothing (just plot)}

\item{...}{further arguments to the plot function}
}
\value{
Either a vector of variance percentages explained, or nothing (just a plot), depending on value of 'return.data'
}
\description{
Make a scree plot using eigenvalues from princomp(), prcomp(), svd(), irlba(), big.PCA(), etc.
Note that most these return values which need to be squared to be proper eigenvalues.
There is also an option to use the estimate.eig.vpcs() function to estimate any missing
eigenvalues (e.g, if using a function like irlba' to calculate PCA) and then to visualise
the fitline of the estimate on the scree plot.
}
\examples{
require(irlba)
nsamp <- 100; nvar <- 300; subset.size <- 25; elbow <- 6
mat <- matrix(rnorm(nsamp*nvar),ncol=nsamp) 
#this gives the full solution
pca <- svd(mat,nv=subset.size,nu=0)
pca2 <- irlba(mat,nv=subset.size,nu=0)
# show alternate fits for linear versus 1/x fit
pca.scree.plot((pca2$d^2)[1:subset.size],n.xax=100,add.fit.line=TRUE,
               min.dim=min(dim(mat)),linear=TRUE, elbow=6, ylim=c(0,1400))
pca.scree.plot((pca2$d^2)[1:subset.size],n.xax=100,add.fit.line=TRUE,
              min.dim=min(dim(mat)),linear=FALSE, elbow=40, ylim=c(0,1400))
subset.size <- 75
pca2 <- irlba(mat,nv=subset.size,nu=0)
pca.scree.plot((pca2$d^2)[1:subset.size],n.xax=100,add.fit.line=TRUE,
              min.dim=min(dim(mat)),linear=TRUE, elbow=6, ylim=c(0,1400))
pca.scree.plot((pca2$d^2)[1:subset.size],n.xax=100,add.fit.line=TRUE,
              min.dim=min(dim(mat)),linear=FALSE, elbow=40, ylim=c(0,1400))
}
\seealso{
\code{\link{pca.scree.plot}}
}
