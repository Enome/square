create = require '../src/validate'
{ required, string, integer, email } = require '../src/validators'

describe 'Example one', ->

  user =
    name: [ required() ]

  validUser = User = null

  beforeEach ->

    User = create user


  describe ':( path', ->

    geert = null

    beforeEach ->

      geert = User name: ''


    it 'calls invalid', (done)->

      geert.validate

        invalid: (errors)->

          errors.should.eql

            name: [ 'String is empty' ]

          done()

  
  describe ':) path', ->

    geert = null

    beforeEach ->

      geert = User name: 'Geert'


    it 'calls valid', (done)->

      geert.validate

        valid: (data)->

          data.should.eql name: 'Geert'

          done()


describe 'Example 2', ->

  user =
    name: [ required(), string() ]
    age:  [ integer() ]
    email: [ required(), email() ]
    password: [ required() ]

  sanitize =
    password: false

  geert = User = null

  beforeEach ->

    User = create user, sanitize


  describe ':( path', ->

    beforeEach ->

      geert = User name: '', age: 'i15.00', email: ''

    
    it 'returns all the errors', (done)->

      geert.validate

        invalid: (errors)->

          errors.should.eql
            name: [ 'String is empty' ]
            age: [ 'Invalid integer' ]
            email: [ 'String is empty', 'Invalid email' ]
            password: [ 'String is empty' ]

          done()


  describe ':) path', ->

    beforeEach ->

      geert = User name: 'Geert', age: '15', email: 'geert.pasteels@gmail.com', password: '1234'


    it 'returns the sanitized object', (done)->

      geert.validate

        valid: (data)->

          data.should.eql
            name: 'Geert'
            age: 15
            email: 'geert.pasteels@gmail.com'

          done()
