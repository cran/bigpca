% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bigpca.R
\name{big.select}
\alias{big.select}
\title{Select a subset of a big.matrix}
\usage{
big.select(bigMat, select.rows = NULL, select.cols = NULL, dir = getwd(),
  deepC = TRUE, pref = "sel", delete.existing = FALSE, verbose = FALSE)
}
\arguments{
\item{bigMat}{a big.matrix, matrix or any object accepted by get.big.matrix()}

\item{select.rows}{selection of rows of bigMat, can be numbers, logical, rownames, or a file with names. 
If using a filename argument, must also use a filename argument for select.cols (cannot mix)}

\item{select.cols}{selection of columns of bigMat, can be numbers, logical, colnames, or a file with names}

\item{dir}{the directory containing the bigMat backing file (e.g, parameter for get.big.matrix()).}

\item{deepC}{logical, whether to use bigmemory::deepcopy, which is slowish, but scalable, or 
alternatively to use standard indexing which converts the result to a regular matrix object,
and is fast, but only feasible for matrices small enough to fit in memory.}

\item{pref}{character, prefix for the big.matrix backingfile and descriptorfile, and optionally
an R binary file containing a big.matrix.descriptor object pointing to the big.matrix result.}

\item{delete.existing}{logical, if a big.matrix already exists with the same name as implied
by the current 'pref' and 'dir' arguments, then default behaviour (FALSE) is to return an error.
to overwrite any existing big.matrix file(s) of the same name(s), set this parameter to TRUE.}

\item{verbose}{whether to display extra information about processing and progress}
}
\value{
A big.matrix with the selected (in order) rows and columns specified
}
\description{
Select a subset of big.matrix using indexes for a subset of rows and columns.
Essentially a wrapper for bigmemory::deepcopy, but with slightly more flexible
parameters. bigMat can be entered in any form accepted by get.big.matrix(), row and
column selections can be vectors of indexes, names or file.names containing indexes.
Default is to process using deepcopy, but processing without using bigmemory native
methods is a faster option when matrices are small versus available RAM. File names
for backing files are managed only requiring you to enter a prefix, or optionally
use the default and gain filebacked functionality without having to bother choosing
filename parameters.
}
\examples{
orig.dir <- getwd(); setwd(tempdir()); # move to temporary dir
if(file.exists("sel.bck")) { unlink(c("sel.bck","sel.dsc")) }
bmat <- generate.test.matrix(5,big.matrix=TRUE)
# take a subset of the big.matrix without using deepcopy
sel <- big.select(bmat,c(1,2,8),c(2:10),
 deepC=FALSE,verbose=TRUE, delete.existing=TRUE)
prv.big.matrix(sel)
# now select the same subset using row/column names from text files
writeLines(rownames(bmat)[c(1,2,8)],con="bigrowstemp.txt")
writeLines(colnames(bmat)[c(2:10)],con="bigcolstemp.txt")
sel <- big.select(bmat, "bigrowstemp.txt","bigcolstemp.txt", delete.existing=TRUE, pref="sel2")
prv.big.matrix(sel)
rm(bmat)
rm(sel)  
unlink(c("bigcolstemp.txt","bigrowstemp.txt","sel.RData","sel2.bck","sel2.dsc"))
setwd(orig.dir) # reset working dir to original
}
\author{
Nicholas Cooper
}
