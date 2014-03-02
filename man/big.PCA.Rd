\name{big.PCA}
\alias{big.PCA}
\title{PCA/Singular Value Decomposition for big.matrix}
\usage{
  big.PCA(bigMat, dir = getwd(), pcs.to.keep = 50,
    thin = FALSE, SVD = TRUE, LAP = FALSE, center = TRUE,
    save.pcs = FALSE, use.bigalgebra = TRUE,
    pcs.fn = "PCsEVsFromPCA.RData", verbose = FALSE, ...)
}
\arguments{
  \item{bigMat}{a big.matrix object, or any argument
  accepted by get.big.matrix(), which includes paths to
  description files or even a standard matrix object.}

  \item{dir}{directory containing the
  filebacked.big.matrix, and also where the output file
  will be saved by default if the save.pcs option is set
  TRUE.}

  \item{pcs.to.keep}{integer, number of principle
  components to keep. Singular Value Decomposition methods
  are able to run faster if they don't need to calculate
  every single PC for a large matrix. Default is to
  calculate only the first 50; in practice even fewer than
  this are generally used directly. Apart from reducing
  processing time, this can also reduce storage/RAM burden
  for the resulting matrix. Set to NA, or a number >=
  min(dim(bigMat)) in order to keep all PCs.}

  \item{thin}{decimal, percentage of the original number of
  rows you want to thin the matrix to.  see function thin()
  for details of how this can be done, pass arguments to
  thin() using ...  Even though this PCA function uses
  mainly 'big.matrix' native methods, there is a step where
  the matrix must be stored fully in memory, so this limits
  the size of what matrix can be processed, depending on
  RAM limits. If you want to conduct PCA/SVD on a matrix
  larger than RAM you can thin the matrix to a percentage
  of the original size. Usually such a large matrix will
  contain correlated measures and so the exclusion of some
  data-rows (variables) will have only a small impact on
  the resulting principle components. In some applications
  tested using this function, using only 5% of 200,000
  variables a PCA gave extremely similar results to using
  the full dataset.}

  \item{SVD}{logical, whether to use a Singular Value
  Decomposition method or a PCA method. The eigenvalues and
  eigenvectors of each alternative will be highly
  correlated so for most applications, such as
  PC-correction, this shouldn't make much difference to the
  result. However, using SVD=TRUE can provide significant
  advantages in speed, or even allow a solution on a matrix
  that would be to large to practically compute full PCA.
  Note that only in SVD mode, and with the bigalgebra
  package installed will the full speed advantage of this
  function be utilised.}

  \item{LAP}{logical, whether to use La.svd() instead of
  svd() when SVD=TRUE, see base:svd for more info.}

  \item{center}{whether to 'centre' the matrix rows by
  subtracting rowMeans() before conducting the PCA. This is
  usually advisable, although you may wish to skip this if
  the matrix is already centred to save extra processing.
  unlike prcomp there is no option to standardize or use
  the correlation matrix, if this is desired, please
  standardize the bigMat object before running this
  function.}

  \item{save.pcs}{whether to save the principle component
  matrix and eigenvalues to a binary file with name pcs.fn}

  \item{pcs.fn}{name of the binary when save.pcs=TRUE}

  \item{verbose}{whether to display detailed progress of
  the PCA}

  \item{use.bigalgebra}{logical, whether to use the
  bigalgebra package for algebraic operations. For large
  datasets bigalgebra should provide a substantial speedup,
  and also facilitates use of larger matrices. This relies
  on having bigalgebra installed and loaded, which requires
  some manual configuration as bigalgebra is not currently
  available on CRAN, but only SVN and RForge. See
  svn.bigalgebra.install() or big.algebra.install.help()
  Default is to use bigalgebra if available (TRUE), but
  setting this FALSE prevents the check for bigalgebra
  which would be cleaner if you know that you don't have it
  installed.}

  \item{...}{if thin is TRUE, then these should be any
  additional arguments for thin(), e.g, 'keep', 'how',
  etc.}
}
\value{
  A list of principle components/singular vectors (may be
  incomplete depending on options selected), and of the
  eigenvalues/singular values.
}
\description{
  description ... ... ...
}
\examples{
# create an example matrix and its transpose
min.dim <- 200; nvar <- 500; subset.size <- 50
mat <- matrix(rnorm(min.dim*nvar),ncol=min.dim)
prv.large(mat)
t.mat <- t(mat)
# create two alternative covariance matrices
MMs <- t.mat \%*\% mat
MsM <- mat \%*\% t.mat
# run singular value decomposition
pca <- svd(mat)
D <- pca$d # singular values (=sqrt(eigenvalues))
V <- pca$v # right singular vector
U <- pca$u # left singular vector
sig <- mat-mat; diag(sig) <- D;
MMs2 <- V \%*\% (t(sig) \%*\% sig) \%*\% t(V)
sig <- t.mat-t.mat; diag(sig) <- D;
MsM2 <- U \%*\% (sig \%*\% t(sig)) \%*\% t(U)
# show that the covariance matrices are equal to the functions of
# the left and right singular vectors
prv(MMs,MsM); prv(MMs2,MsM2)
pr <- princomp(mat) # PCA using eigendecomposition of cov matrix
L <- matrix(rep(0,40000),ncol=200); diag(L) <- pr[[1]]^2 # eigenvalues as diag
mat2 <- (pr[[2]]) \%*\% L \%*\%  solve(pr[[2]]) # = eigenvectors * eigenvalues * inv(eigenvectors)
prv.large(cov(mat)); prv.large(mat2) #  == COVmat (may be slight tolerance differences)
## Now demonstrate the correlation between SVD and PCA ##
# the right singular vector is highly correlated with the pca loadings:
median(abs(diag(cor(V,pr[["loadings"]]))))
# the left singular vector is highly correlated with the pca scores (eigenvectors):
median(abs(diag(cor(U,pr[["scores"]]))))
cor(pr$sdev,D) # the singular values are equivalent to the eigenvalues

## MAIN EXAMPLES ##
bmat <- as.big.matrix(mat,backingfile="testMyBig.bck",descriptorfile="testMyBig.dsc")
result <- big.PCA(bmat) #,verbose=TRUE)
headl(result)
# plot the eigenvalues with a linear fit line and elbow placed at 13
Eigv <- pca.scree.plot(result$Evalues,M=bmat,elbow=6,printvar=FALSE)
##  generate some data with reasonable intercorrelations ##
mat2 <- sim.cor(500,200,genr=function(n){ (runif(n)/2+.5) })
bmat2 <- as.big.matrix(mat2,backingfile="testMyBig.bck",descriptorfile="testMyBig.dsc")
# calculate PCA on decreasing subset size
result2 <- big.PCA(bmat2,thin=FALSE)
result3 <- big.PCA(bmat2,thin=TRUE,keep=.5)
result4 <- big.PCA(bmat2,thin=TRUE,keep=.5,how="cor")
result5 <- big.PCA(bmat2,thin=TRUE,keep=.5,how="pca")
result6 <- big.PCA(bmat2,thin=TRUE,keep=.2)
normal <- result2$PCs
thinned <- result3$PCs
corred <- result4$PCs
pced <- result5$PCs
thinner <- result6$PCs
## correlate the resulting PCs with the un-thinned PCs
cors.thin.with.orig <- apply(cor(normal,thinned),1,max)
cors.corred.with.orig <- apply(cor(normal,corred),1,max)
cors.pced.with.orig <- apply(cor(normal,pced),1,max)
cors.thinner.with.orig <-apply(cor(normal,thinner),1,max)
plot(cors.thin.with.orig,type="l",col="red",ylim=c(0,1))
lines(cors.thinner.with.orig,col="orange")
lines(cors.corred.with.orig,col="lightblue")
lines(cors.pced.with.orig,col="lightgreen")
# can see that the first component is highly preserved,
# and next components, somewhat preserved; try using different thinning methods
unlink(c("testMyBig.bck","testMyBig.dsc"))
}
\author{
  Nicholas Cooper
}
\seealso{
  get.big.matrix, PC.correct
}

