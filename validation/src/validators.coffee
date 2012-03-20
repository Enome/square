{ check, sanitize } = require 'validator'

module.exports =

  required: (msg)->

    (data, invalid, valid)->

      try
        check(data, msg).notEmpty()
      catch e
        return invalid e.message

      valid data


  integer: (msg)->

    (data, invalid, valid)->

      if data
        try
          check(data, msg).isInt()
        catch e
          return invalid e.message

        valid sanitize(data).toInt()

      else
        valid()

  decimal: (msg)->

    (data, invalid, valid)->

      try
        check(data, msg).isDecimal()
      catch e
        return invalid e.message

      valid data


  string: (msg)->

    (data, invalid, valid)->

      valid data?.toString()

  
  email: (msg)->

    (data, invalid, valid)->

      try
        check(data, msg).isEmail()
      catch e
        return invalid e.message

      valid data


  compare: (msg)->

    (data, invalid, valid)->

      prev = null

      for d in data

        if prev? and prev isnt d
          return invalid msg or 'Values are not equal'

        prev = d

      valid data[0]
