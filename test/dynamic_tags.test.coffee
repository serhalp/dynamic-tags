require './test-helper'

_ = require 'underscore'

dynamicTags = require '..'

given 'a registered "gluten-free" tag', ->
  before ->
    dynamicTags.registerTag 'gluten-free', (obj) ->
      _(obj.ingredients)
        .every (ingredient) -> 'gluten-free' in ingredient.tags

  given 'all gluten-free ingredients', ->
    {meal} = {}

    before ->
      meal =
        name: 'Sourdough Loaf'
        ingredients: [
          {
            name: 'Organic White Rice Flour'
            tags: [ 'vegan', 'gluten-free', 'dairy-free', 'sodium-free' ]
          },
          {
            name: 'Organic Millet Flour'
            tags: [ 'vegan', 'gluten-free', 'dairy-free', 'sodium-free' ]
          },
          {
            name: 'Salt'
            tags: [ 'vegan', 'gluten-free', 'dairy-free' ]
          }
        ]

    it 'tags as gluten-free', ->
      expect(dynamicTags.computeTag 'gluten-free', meal).to.be.true

  given 'some gluten-free ingredients', ->
    {meal} = {}

    before ->
      meal =
        name: 'German Rye'
        ingredients: [
          {
            name: 'Organic Whole Rye Flour'
            tags: [ 'vegan', 'dairy-free', 'sodium-free' ]
          },
          {
            name: 'Water'
            tags: [ 'vegan', 'gluten-free', 'dairy-free', 'sodium-free' ]
          },
          {
            name: 'Salt'
            tags: [ 'vegan', 'gluten-free', 'dairy-free' ]
          }
        ]

    it 'does not tag as gluten-free', ->
      expect(dynamicTags.computeTag 'gluten-free', meal).to.be.false

  given 'no gluten-free ingredients', ->
    {meal} = {}

    before ->
      meal =
        name: 'Whole Wheat Baguette'
        ingredients: [
          {
            name: 'Unbleached Organic Wheat Flour'
            tags: [ 'vegan', 'dairy-free', 'sodium-free' ]
          },
          {
            name: 'Organic Whole Wheat Flour'
            tags: [ 'vegan', 'dairy-free', 'sodium-free' ]
          },
          {
            name: 'Organic Whole Rye Flour'
            tags: [ 'vegan', 'dairy-free', 'sodium-free' ]
          }
        ]

    it 'does not tag as gluten-free', ->
      expect(dynamicTags.computeTag 'gluten-free', meal).to.be.false
