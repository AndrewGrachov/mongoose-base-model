module.exports =(searchString,data,callback)->
    self = @

    actions =
        getSearchQuery:(callback)->
            if searchString.length<3
                callback new Error('Search term is too short') #todo: custom errors
            else
                @getSearchQuery(data,searchString,callback)
        restrictQueryAndGetEntities:(query,callback)->

            mongooseQuery = @find(query)
            mongooseQuery = @paginateQuery(mongooseQuery,data.pagingOptions)
            @count(query).exec (err,count)->
                if err
                    callback err
                else
                    mongooseQuery.exec (err,results)->
                        response =
                            count:count
                        response[self.collection.name] = results
                        callback err,results
    async.waterfall [
                        actions.getSearchQuery,
                        actions.restrictQueryAndGetEntities
                    ],callback