mongoose = require('mongoose');
_u = require("underscore");

construct = require "./construct"
search = require "./search"

statics = require "./statics"
middleware =require "./middleware"


module.exports = (schema,options)->
    schema.statics = _u.extend(schema.statics,statics)


    schema.add({cd:{type:"Date",'default':Date.now()}})
    schema.add({lm:{type:"Date",'default':Date.now()}})
    schema.pre 'save',middleware.save

    #plug in constructor. constructor will exclude all fields from raw json data, which marked with 'cloak' attribute
    schema.plugin(construct)

    #plug in search plugin. will search doc fields marked with 'search' attr by regex filter
    schema.plugin(search)

