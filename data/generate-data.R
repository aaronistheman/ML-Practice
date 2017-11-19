# Generate data that is linear function of some features,
# and write to file. Only uses integers, not floats.
# Not really intended for general purpose use.
# Sample usage:
# $ Rscript generate-data.R data.txt

# In case we don't want the error function to always be Gaussian.
error = function(n) {
    return(rnorm(n))
}

# Generate y values with some noise applied.
generate_y = function(X, c, num_samples) {
    y = as.integer(X %*% c + error(num_samples))
    return(y)
}

# These can be changed. The goal for a predictor using this data is to
# predict them.
get_c_values = function() {
    return(c(10, 5, 2))
}

generate_X = function(num_samples, num_features) {
    min_x_value = -1000
    max_x_value = 1000
    x_values = as.integer(runif(num_features * num_samples,
        min_x_value, max_x_value))
    X = matrix(x_values, nrow=num_samples, ncol=num_features, byrow=TRUE)
    return(X)
}

args <- commandArgs(trailingOnly = TRUE)
fileName = args[1]

# Create the data.
c = get_c_values()
ns = 100
nf = 3
X = generate_X(ns, nf)
y = generate_y(X, c, ns)

# Write the data (i.e. write X and y put together).
combinedMatrix = cbind(X, y)
write.table(combinedMatrix, file=fileName, sep="   ",
    row.names=FALSE,
    col.names=c("x1", "x2", "x3", "y"), quote=FALSE)
