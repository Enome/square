sinon = require 'sinon'
signals = require('./src')

describe 'Signals', ->

  describe 'Wraps the node event emitter', ->

    it 'does basic on and emit', (done)->

      sigs = signals()

      called = false

      sigs.on 'call it', (callback)->

        called = true

        callback()

      sigs.emit 'call it', ->

        called.should.be.true

        done()

  describe 'Debug Lvl', ->

    logger = null

    beforeEach ->

      logger = sinon.spy()
      sigs = signals logger

      process.env.NODE_DEBUG_LVL = '1'

      sigs.on 'call it', ->
      sigs.emit 'call it'

    describe 'Lvl one', ->

      it 'logs Added signal', ->

        logger.args[0][0].should.eql 'Added signal: call it'

      it 'logs Added signal', ->

        logger.args[1][0].should.eql 'Emit signal: call it'
