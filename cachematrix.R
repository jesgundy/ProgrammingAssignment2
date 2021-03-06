## Used to create a custom maatrix object (list) which caches it's own inverse once calculated. Cached inverse must be accessed via the corresponding `cacheSolve` method. The cached inverse is also removed when the object is given a new matrix.
makeCacheMatrix <- function(m = matrix()) {
  ## Inverse null by default
  m.inverse <- NULL
  
  
  ## Getter Functions
  get.matrix <- function() m
  get.inverse <- function() m.inverse
  
  
  ## Setter functions
  set.matrix <- function(new.matrix) {
    m <<- new.matrix
    m.inverse <<- NULL ## Reset inverse
  }
  set.inverse <- function(new.inverse) {
    m.inverse <<- new.inverse
  }
  
  
  ## Return Special Matrix Object (list)
  list(
    set.matrix = set.matrix,
    get.matrix = get.matrix,
    set.inverse = set.inverse,
    get.inverse = get.inverse
  )
}



## Function used to access the (potentially) cached inverse of a custom matrix object generated by the `makeCacheMatrix` function. If the inverse has not yet been calculated, it will be stored on the custom matrix object for later use.
cacheSolve <- function(matrix.object, ...) {
  ## Get the Inverse via the getter function
  cached.inverse <- matrix.object$get.inverse()
  
  
  ## If it's already been calculated, return it
  if( !is.null(cached.inverse) ) {
    message("Getting cached inverse...")
    return(cached.inverse)
  }
  
  
  ## Otherwise, calculate the inverse
  message("Calculating new inverse...")
  new.inverse <- solve(matrix.object$get.matrix(), ...)
  
  
  ## Cache it with the setter method
  matrix.object$set.inverse(new.inverse)
  
  
  ## Return the new inverse
  new.inverse
}
