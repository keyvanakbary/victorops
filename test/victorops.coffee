assert = require 'assert'
VictorOps = require '../src/victorops'

describe 'VictorOps', ->

  beforeEach ->
    @httpClient = new HttpClientSpy
    @victorops = new VictorOps('s3cr3tKey', @httpClient)

  describe 'alert', ->

    it 'should send request to end point', ->
      @victorops.alert()
      assert.equal 'https://alert.victorops.com/integrations/generic/20131114/alert/s3cr3tKey/everyone', @httpClient.parameters.url
      assert.equal 'POST', @httpClient.parameters.method
      assert.equal 'application/json', @httpClient.parameters.headers['Content-Type']

    it 'should build the parameters body', ->
      @victorops.alert
        message_type: 'DEBUG'
        state_message: 'test'

      assert.equal '{"message_type":"DEBUG","state_message":"test"}', @httpClient.parameters.body

    it 'should propagate http exception', ->
      @httpClient.request = -> throw new Error
      assert.throws (=> @victorops.alert()), Error

    it 'should raise exception on erroneous response', ->
      @victorops.alert()
      assert.throws => @httpClient.parameters.done '{"result":"error","messages":"test"}'

class HttpClientSpy
  parameters: {}

  request: (parameters) ->
    @parameters = parameters