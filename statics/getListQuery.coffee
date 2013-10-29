module.exports = (data,callback)->
    #designed to be used in asynchronous control flow libs like async.js
    #if you want to specify custom filters, just re-define this method in your model statics
    ###EXAMPLE
        if data.user.isInRole "admin"
            callback null,{}
        else if data.user.isInRole "user"
            callback null,{ownerId:data.userId}
    ###
    callback null,{}