module.exports = (data,searchTerm,callback)->
                    self = @
                    @getListQuery data,(err,query)->  #should be defined in every entity
                        if err
                            callback err
                        else
                            query = self.addSearchParamsToQuery(query,searchTerm)
                            callback err,query