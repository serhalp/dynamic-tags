chai = require 'chai'
global.expect = chai.expect

process.env.NODE_ENV ?= 'test'

class global.given extends global.describe
  constructor: (description, callback) ->
    description = "given #{description}"
    super description, callback
