validate = (data, sanitize, rules, callbacks)->

  validatorsAmount = 0
  calls = 0
  errors = {}
  sanitizedData = {}

  globalCallback = ->

    calls += 1

    if calls is validatorsAmount
      if Object.keys(errors).length
        callbacks.invalid?( errors )
      else
        callbacks.valid?(sanitizedData)

  callbackValid = (key, data)->

    sanitizedData[key] = data

    if sanitize? and key in Object.keys(sanitize)

      delete sanitizedData[key]

    globalCallback()

  callbackInvalid = (key, error)->

    errors[key] = [] unless errors[key]
    errors[key].push error
    globalCallback()


  map = {}

  # Get all the rules

  for k, v of rules

    validatorsAmount += v.length

    map[k] =

      validators: v

  # Get all the data

  for k,v of data

    map[k]?.data = v

  # Apply all the validators to the data

  for k, v of map

    for validator in v.validators

      validator v.data, callbackInvalid.bind(this, k), callbackValid.bind(this, k)


module.exports = (rules, sanitize)->

  (data)->

    validate: (callbacks)->

      validate data, sanitize, rules, callbacks
