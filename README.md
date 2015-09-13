# VictorOps

[![Build Status](https://secure.travis-ci.org/keyvanakbary/victorops.svg?branch=master)](http://travis-ci.org/keyvanakbary/victorops)

Client for [VictorOps](https://victorops.com/).

## Installation

    npm install victorops

## Usage

```javascript
var VictorOps = require('victorops');

var client = VictorOps.create('SECRET_KEY');
client.alert({
    message_type: 'INFO'
    state_message: 'test'
}, 'everyone');
```

Check out all the options available at [VictorOps API](http://victorops.force.com/knowledgebase/articles/Integration/Alert-Ingestion-API-Documentation/).
