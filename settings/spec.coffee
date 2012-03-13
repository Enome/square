settings = require('./src')

describe 'Settings', ->

  beforeEach ->

    process.env.NODE_ENV = ''

    settings.general =

      database: 'somedatabase'
      cost: '2.00'
      
    settings.development =
      
      cost: '3.00'
      domain: 'enome.be'

    settings.production =

      domain: 'friendly-stranger.com'
      path: '/somewhere/someplace'


  describe 'general', ->

    it 'returns somedatabase and 2.00', ->

      settings.create().should.eql

        database: 'somedatabase'
        cost: '2.00'

  describe 'development', ->

    it 'returns somedatabase, 3.00 and enome.be', ->

      process.env.NODE_ENV = 'development'

      settings.create().should.eql

        database: 'somedatabase'
        cost: '3.00'
        domain: 'enome.be'

  describe 'production', ->

    it 'returns friendly-stranger.com, 3.00 and /somewhere/someplace', ->

      process.env.NODE_ENV = 'production'

      settings.create().should.eql

        database: 'somedatabase'
        cost: '2.00'
        domain: 'friendly-stranger.com'
        path: '/somewhere/someplace'
