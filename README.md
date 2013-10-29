mongoose-base-model
===================

base model plugin  for mongoose ODM

install
=======================
npm install mongoose-base-model

use
=======================



features:
=======================

1.metadata-based constructor.

just mark your mongoose model fields with "cloak:true" attribute, and these fields will be excluded from raw json object.

call Model.construct(rawJsonObject) to get model

//todo:example

2.Paging filter
pass your mongoose query(e.g Model.find({}) hook) alongside with paging options to Model.paginateQuery

query = Model.find({})
pagingOptions ={
	limit:30,
	skip:0,
	sort:"cd" //or "-cd" to reverse order
}
 

readyToExecuteQuery = Model.paginateQuery(query,pagingOptions)  
readyToexecuteQuery.exec (err,entities)->
	//do something with entities

2.metadata-based regex search

mark your fields with "search:true" attribute, and they will be included in mongo $regex search

call Model.search(data,(err,result)->)	

data can include pagingOptions field(see above), otherwise it will use standard values(limit 50)
and will produce result like 
{
 count:30,
 collectionName:[entitiesCollection] 

} 
//collection name is based on name of your mongodb collection. e.g. if you have collection named 'users'
//result will be 
//   {count:30,users:[arrayOfUsers]} 

Advanced
=========================
in 90 % cases we should restrict find results by some condition, based on user.role or something.
Thats right also about search.
Search query is beign built from 2 static public methods - addSearchParamsToQuery and getListQuery


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

If you want custom list query filter, just define your Model.statics.getListQuery(data,callback) after you use the plugin 

when you call Model.search(searchTerm,data,callback)
'data' variable will be used to construct query from getListQuery method

customization
=========================
todo:update doc

