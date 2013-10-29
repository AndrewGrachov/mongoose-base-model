mongoose =require "mongoose"
helpers = require('./helpers')

module.exports = (schema,options)->
    schema['static'] "modify", (fields) ->
        copiedFields = helpers.copy(fields)
        tree = @schema.tree
        copiedFields = helpers.excludeProtectedFields(tree, copiedFields)
        copiedFields

    schema.method "construct", (fields) ->
        safeFields = @constructor.modify(fields)
        @set safeFields
        this

    schema['static'] "construct", (fields) ->
        model = new this()
        model.construct fields
        model