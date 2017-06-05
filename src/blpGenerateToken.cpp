// -*- mode: C++; c-indent-level: 4; c-basic-offset: 4; indent-tabs-mode: nil; -*-
//
//  genToken.cpp -- Function to generate Bloomberg authentication tokens
//
//  Copyright (C) 2017  Christopher Dudley
//
//  This file is part of Rblpapi
//
//  Rblpapi is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 2 of the License, or
//  (at your option) any later version.
//
//  Rblpapi is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with Rblpapi.  If not, see <http://www.gnu.org/licenses/>

#include <string>
#include <blpapi_session.h>
#include <blpapi_event.h>
#include <blpapi_message.h>
#include <Rcpp.h>
#include <blpapi_utils.h>

using BloombergLP::blpapi::Session;
using BloombergLP::blpapi::Service;
using BloombergLP::blpapi::Request;
using BloombergLP::blpapi::Event;
using BloombergLP::blpapi::EventQueue;
using BloombergLP::blpapi::Message;
using BloombergLP::blpapi::MessageIterator;
using BloombergLP::blpapi::Name;
using BloombergLP::blpapi::CorrelationId;

namespace {
    const Name TOKEN_SUCCESS("TokenGenerationSuccess");
    const Name TOKEN_FAILURE("TokenGenerationFailure");
}

// [[Rcpp::export]]
std::string blpGenerateToken_Impl(SEXP con_) {
    // via Rcpp Attributes we get a try/catch block with error propagation to R "for free"
    Session* session = 
        reinterpret_cast<Session*>(checkExternalPointer(con_, "blpapi::Session*"));

    CorrelationId tokenGenerationId;
    EventQueue tokenEventQueue;
    std::string token;
    session->generateToken(tokenGenerationId, &tokenEventQueue);

    Event tokenEvent = tokenEventQueue.nextEvent();
    for (MessageIterator messageIterator(tokenEvent); messageIterator.next(); ) {
        Message message = messageIterator.message();
        if (TOKEN_FAILURE == message.messageType()) {
            Rcpp::stop("Token generation failed\n");
        }
        assert(TOKEN_SUCCESS == message.messageType());
        token.assign(message.getElementAsString("token"));
        break;
    }
    return token;
}