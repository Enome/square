extend = (source, replacement)->

  copy = {}

  for k,v of source

    copy[k] = v

  for k, v of replacement

    copy[k] = v

  copy


module.exports =

  create: ->

    env_settings = this[process.env.NODE_ENV]

    extend this.general, env_settings
