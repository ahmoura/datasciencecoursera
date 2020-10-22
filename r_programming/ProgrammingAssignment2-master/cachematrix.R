# input:       x: matrix
# output:      obj with the cache of inverse matrix 

makeCacheMatrix <- function(x = matrix()) {
  inverse.x <- NULL # drop inverse value
  
  #set a value inside a matrix and drop the value of the inverse one
  set <- function(y){
    x <<- y
    inverse.x <<- NULL # set the var that already exists
  }

  get <- function() x
  
  setinverse <- function(inv){
    inverse.x <<- inv
  }
  getinverse <- function() inverse.x
  
  list(set = set, get = get,
       setinverse = setinverse, getinverse = getinverse)
}


# input:       x: makeCacheMatrix obj
# output:     the inverse of matrix

cacheSolve <- function(x, ...) {
  inverse.x <- x$getinverse() # retrieve inverse
  if(!is.null(inverse.x)){
    message("getting cached data")
    return(inverse.x)
  }
  data <- x$get()
  inverse.x <- solve(data,...)
  x$setinverse(inverse.x)
  inverse.x

}

# mat <- matrix(1:4, nrow = 2, ncol = 2)
# MCM <- makeCacheMatrix(mat)
# cacheSolve(MCM)