exports.redirect = (url)->
  
  (req, res)->

    res.redirect url

exports.render = (view)->
  
  (req, res)->

    res.render view

exports.send = (s)->

  (req, res)->

    res.send s
