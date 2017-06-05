
##
##  Copyright (C) 2017 Christopher Dudley
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

##' This function generates a new token that can be used to further
##' authenticate against the Bloomberg API via B-PIPE.
##'
##' @title Generate Bloomberg Security Token
##' @param con A connection object as created by a \code{blpConnect}
##' call. If not specified, the default connection is retrieved
##' via the internal function \code{defaultConnection}.
##' @return A character vector containing the generated token.
##' @author Christopher Dudley

blpGenerateToken <- function(con=defaultConnection()) {
    blpGenerateToken_Impl(con)
}