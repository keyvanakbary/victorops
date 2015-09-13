HttpClient = require './http_client'

class VictorOps

  END_POINT = 'https://alert.victorops.com/integrations/generic/20131114/'
    
  @create: (apiKey) ->
    new VictorOps(apiKey, new HttpClient())

  constructor: (@apiKey, @httpClient) ->

  alert: (parameters, routingKey = 'everyone') ->
    @httpClient.request
      method: 'POST'
      url: END_POINT + "alert/#{@apiKey}/#{routingKey}"
      body: JSON.stringify(parameters)
      headers: 'Content-Type': 'application/json'
      done: failOnError

  failOnError = (response) ->
    data = JSON.parse(response)
    throw "Error #{data.messages}" if data.result isnt 'success'
  
module.exports = VictorOps