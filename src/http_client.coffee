http = require 'http'
https = require 'https'
querystring = require 'querystring'
parser = require 'url'

class HttpClient
  request: (parameters) ->
    request = protocolFor(parameters.url).request buildOptions(parameters), (response) ->
      response.setEncoding 'utf8'
      response.on 'data', parameters.done or (response) ->
    request.on 'error', parameters.error or (error) -> throw error
    request.write parameters.body or ''
    request.end()

  protocolFor = (url) ->
    parsedUrl = parser.parse(url)
    if parsedUrl.protocol is 'https:' then https else http

  buildOptions = (parameters) ->
    parsedUrl = parser.parse(parameters.url)
    {
      method: parameters.method or 'GET'
      host: parsedUrl.host
      port: parsedUrl.port
      path: parsedUrl.path
      headers: parameters.headers or {}
    }

module.exports = HttpClient