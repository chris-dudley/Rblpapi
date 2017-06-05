
##
##  Copyright (C) 2015  Whit Armstrong and Dirk Eddelbuettel and John Laing
##
##  This file is part of Rblpapi
##
##  Rblpapi is free software: you can redistribute it and/or modify
##  it under the terms of the GNU General Public License as published by
##  the Free Software Foundation, either version 2 of the License, or
##  (at your option) any later version.
##
##  Rblpapi is distributed in the hope that it will be useful,
##  but WITHOUT ANY WARRANTY; without even the implied warranty of
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##  GNU General Public License for more details.
##
##  You should have received a copy of the GNU General Public License
##  along with Rblpapi.  If not, see <http://www.gnu.org/licenses/>.


##' This function authenticates against the the Bloomberg API
##'
##' @title Authenticate Bloomberg API access
##' @param uuid A character variable with a unique user id token
##' @param host A character variable with a hostname, defaults to 'localhost'
##' @param ip.address An optional character variable with an IP address
##' @param token An optional character variable with an authentication token
##' @param con A connection object as created by a \code{blpConnect}
##' call, and retrieved via the internal function
##' \code{defaultConnection}.
##' @return An identity object that may be used to authorize further requests.
##' @author Whit Armstrong and Dirk Eddelbuettel

blpAuthenticate <- function(uuid,
                            host="localhost",
                            ip.address,
                            token,
                            con=defaultConnection()) {
    if (missing(ip.address) && missing(token)) {
        ## Linux only ?
        cmd.res <- system(paste("host",host), intern=TRUE,
                          ignore.stdout=FALSE, ignore.stderr=FALSE,wait=TRUE)
        ip.address <- strsplit(cmd.res,"address ")[[1]][2]
    } else if (missing(ip.address)) {
        ip.address <- NULL
    }
    
    if (!missing(uuid) && storage.mode(uuid) != "character") {
        stop("UUID argument must be character.")
    } else if (missing(uuid)) {
        uuid <- NULL
    }

    authenticate_Impl(con, uuid, ip.address, token)
}

#### TODO: rename to just 'authenticate' ?

