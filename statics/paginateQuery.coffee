module.exports = (query,options)->
    #by default we will use standard skip,limit,sort options
    ###
    options.limit
    options.sort
    options.skip
    ###

    sort = options.sort or "-cd"
    limit = options.limit || 50 #by default
    skip = options.skip || 0

    query = query.sort(sort).skip(skip).limit(limit)