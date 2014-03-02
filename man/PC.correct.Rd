\name{PC.correct}
\alias{PC.correct}
\title{Correct a big.matrix by principle components}
\usage{
  PC.correct(pca.result, bigMat, dir = getwd(),
    num.pcs = 9, n.cores = 1, pref = "corrected",
    big.cor.fn = NULL, write = FALSE, sample.info = NULL,
    correct.sex = FALSE, add.int = FALSE, tracker = TRUE)
}
\arguments{
  \item{pca.result}{result returned by 'big.pca()', or a
  list with 2 elements containing the principle components
  and the eigenvalues respectively (or SVD equivalents).
  Alternatively, can be the name of an R binary file
  containing such an object.}

  \item{bigMat}{a big.matrix with exactly corresponding
  samples (columns) to those submitted to PCA prior to
  correction}

  \item{dir}{directory containing the big.matrix backing
  file}

  \item{num.pcs}{number of principle components (or SVD
  components) to correct for}

  \item{n.cores}{number of cores to use in parallel for
  processing}

  \item{pref}{prefix to add to the file name of the
  resulting corrected matrix backing file}

  \item{big.cor.fn}{instead of using 'pref' directly
  specify the desired file name}

  \item{write}{whether to write the result to a file.backed
  big.matrix or to simply return a pointer to the resulting
  corrected big.matrix}

  \item{sample.info}{if using 'correct.sex=TRUE' then this
  object should be a dataframe containing the sex of each
  sample, with sample names as rownames}

  \item{correct.sex}{if sample.info is a dataframe
  containing a column named 'gender' or 'sex' (case
  insensitive), then add a sex covariate to the PC
  correction linear model}

  \item{add.int}{whether to maintain the pre-corrected
  means of each variable, i.e, post-correction add the mean
  back onto the residuals which will have mean zero for
  each variable.}

  \item{tracker}{logical, whether to display a progress
  bar}
}
\value{
  A big.matrix of the same dimensions as original,
  corrected for n PCs and an optional covariate (sex)
}
\description{
  Principle components (PC) can be used as a way of
  capturing bias (when common variance represents bias) and
  so PC correction is a way to remove such bias from a
  dataset. Using the first 'n' PCs from an an analysis
  performed using big.pca(), this function will transform
  the original matrix by regressing onto the 'n' principle
  components (and optionally gender) and returing the
  residuals. The result is returned as a big.matrix object,
  so that objects larger than available RAM can be
  processed, and multiple processors can be utilised for
  greater speed for large datasets.
}
\examples{
mat2 <- sim.cor(500,200,genr=function(n){ (runif(n)/2+.5) })
bmat2 <- as.big.matrix(mat2,backingfile="testMyBig.bck",descriptorfile="testMyBig.dsc")
# calculate PCA
packages.loaded()
# result2 <- big.PCA(bmat2,thin=FALSE)
# corrected <- PC.correct(result2,bmat2)
# corrected2 <- PC.correct(result2,bmat2,n.cores=2)
# all.equal(corrected,corrected2)
unlink(c("testMyBig.bck","testMyBig.dsc"))
}
\author{
  Nicholas Cooper
}
\seealso{
  big.pca
}

