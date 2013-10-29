deepPath = (obj, path) ->
    i = 0
    path = path.split(".")
    len = path.length

    while i < len
        obj = obj[path[i]]
        i++
    obj

module.exports = (mongooseModelTree, copiedData) ->
    __excludeProtected = (path, object) ->
        for property of object
            combinedPath = (if (path? and path isnt `undefined`) then path + "." + property else property)
            mongooseField = deepPath(mongooseModelTree, combinedPath)
            unless mongooseField # mongoose does allow writing any data non-related to objects in nested schemas. we don't
                delete object[property]
            else if object[property] instanceof Array #if array, do nested search for array

                #double check path
                mongooseArraySchema = deepPath(mongooseModelTree, combinedPath)

                #nested array schema can be defined 2 ways - by [] or {items:[]}. lets check if it will work with items
                mongooseArraySchema = deepPath(mongooseModelTree, combinedPath + ".items")  unless mongooseArraySchema instanceof Array
                unless mongooseArraySchema instanceof Array

                    #not valid schema, should delete
                    delete object[property]
                else
                    combinedPath += ".0"
                    i = 0

                    while i < object[property].length
                        __excludeProtected combinedPath, object[property][i]
                        i++
            else if mongooseField and mongooseField.cloak #check and delete cloaked fields.
                delete object[property]
            else if typeof object[property] is "object" #if object, do nested search
                __excludeProtected combinedPath, object[property]
            else


                #test no action.do nothing. ccompletely nothing
    __excludeProtected null, copiedData
    copiedData