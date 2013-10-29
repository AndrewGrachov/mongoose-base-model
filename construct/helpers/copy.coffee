module.exports = (initialObject) ->
    newObject = {}
    copy = (obj1, obj2) ->
        for key of obj1
            obj2[key] = obj1[key]
            copy obj1[key], obj2[key]  if typeof obj1[key] is "object"

    copy initialObject, newObject
    newObject