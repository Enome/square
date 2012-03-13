{ EventEmitter } = require 'events'

module.exports = (logger)->

  logger = (->) unless logger?

  ee = new EventEmitter

  {
    on: (name, callback)->

      ee.on name, callback

      if process.env.NODE_DEBUG_LVL is '1'

        logger 'Added signal: ' + name

    emit: (name, args...)->

      ee.emit name, args...

      if process.env.NODE_DEBUG_LVL is '1'

        logger 'Emit signal: ' + name
  }
