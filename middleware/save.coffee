module.exports = (next)->
    @lm = Date.now()
    next()