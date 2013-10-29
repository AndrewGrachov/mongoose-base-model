helpers = require "./helpers"
async = require "async"

module.exports = (schema,options)->
    #schema.getSearch
    schema.statics.addSearchParamsToQuery = helpers.addSearchParamsToQuery
    schema.statics.getSearchQuery =  helpers.getSearchQuery

    #todo:implement. do not forget about paging options
    schema.statics.search =require "./search"