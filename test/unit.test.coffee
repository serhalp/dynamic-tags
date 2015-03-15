require './test-helper'

dynamicTags = require '..'

describe 'registerTag method', ->
  it 'should be defined', ->
    expect(dynamicTags.registerTag).to.be.a 'function'
  it 'should return undefined', ->
    expect(dynamicTags.registerTag 'gluten-free', ->).to.be.undefined

describe 'computeTag method', ->
  it 'should be defined', ->
    expect(dynamicTags.computeTag).to.be.a 'function'
  
  describe 'called with an unknown tag', ->
    it 'should return undefined', ->
      expect(dynamicTags.computeTag 'gluten-free', {}).to.be.undefined

  describe 'called with a registered tag', ->
    it 'should return the result of the registered callback', ->
      cb = (obj) -> true
      dynamicTags.registerTag('gluten-free', cb)
      expect(dynamicTags.computeTag 'gluten-free', {}).to.equal cb({})
