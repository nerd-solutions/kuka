  Template.registerHelper 'formatTime',(val,format)->
    moment(val).format(format)
