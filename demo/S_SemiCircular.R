#' This script illustrate the semi-circular law of random matrix theory, as described in A. Meucci, 
#' "Risk and Asset Allocation", Springer, 2005,  Chapter 4.
#'
#' @references
#' \url{http://symmys.com/node/170}
#' See Meucci's script for "S_SemiCircular.m"
#'

##################################################################################################################
### Inputs
N = 1000; # matrix size

##################################################################################################################
### Empirical eigenvalues

#X=rnorm(N);                # normal
#X=( runif(N)-0.5 ) * sqrt(12);   # uniform
X = log( matrix( runif(N^2), N, N )) + 1;           # exponential

Y = (X + t(X) ) / ( 2 * sqrt( 2 * N ));    # symmetrize and rescale
E = t(eigen(Y)$values);

##################################################################################################################
### Theoretical eigenvalues
t = seq( -1, 1, 0.01 ); 
g = 2 / pi * sqrt(1 - t^2);

NumBins = ceiling( 10 * log( length( E )));
h = hist(E, NumBins, plot = FALSE); 
t_= h$mids;
b = h$counts;
D = t_[ 2 ] - t_[ 1 ];
h = b / (D * N);

##################################################################################################################
### Plots
dev.new();
#bar(t_, h);
plot(t_, h, type = "h", lwd = 5);
lines(t, g, col = "red", lwd = 3);