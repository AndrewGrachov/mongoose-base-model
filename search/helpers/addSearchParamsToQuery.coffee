module.exports = (query,searchString)->
    #lets pretend we have query {userId:"string"}
    #lets get all fields marked with 'search' attribute
    #flat for now
    tree = @schema.tree
    conditionsArray = []

    addSearchParam = (object,parentPath)->   #todo:nested search for fields marked with search

        for property of object
            #console.log("#{property}:",object[property])
            if object[property] and object[property].search
                additionalCondition = {}
                pathName = property
                if parentPath
                    pathName = "#{parentPath}.#{property}"
                additionalCondition[pathName] = new RegExp(searchString,"i")
                conditionsArray.push(additionalCondition)

    #parentPath = if not parentPath then property else parentPath+".#{property}"
    #addSearchParam(object[property],parentPath)

    addSearchParam(tree)
    console.log("conditionsArray:",conditionsArray)

    if query.$and

        query.$and.push {$or:conditionsArray}
    else
        query.$and = [{$or:conditionsArray}]
    query
