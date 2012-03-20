recorder = ( require 'express-recorder' ).middleware

{ required, compare } = require '../src/validators'
create  = require '../src/validate'

middleware = require '../src/middleware'

extend = (o1, o2)->
  n = {}
  n[k] = v for k, v of o1
  n[k] = v for k,v of o2
  n

credentials = create

  name: [ required() ]
  username: [ required() ]
  password: [ compare() ]
  password1: [ required() ]
  password2: [ required() ]
,
  password1: false
  password2: false

createLocalValidator = (data)->

  credentials data

describe 'middleware', ->

  badCredentials =
    name: 'Geert'
    username: ''
    password: ['1234', '5678']
    password1: '1234'
    password2: '5678'

  body = somestuff: 'doesnt matter'

  goodCredentials =
    name: 'Geert'
    username: 'Pickels'
    password: ['1234', '1234']
    password1: '1234'
    password2: '1234'

  describe ':(', ->

    it 'renders the form view and sets the errors and form_model locals', (done)->

      locals = validator: createLocalValidator(badCredentials)

      recorder middleware('form') , { body, locals }, (result)->

        result.eql
          locals:
            form_model: somestuff: 'doesnt matter'
            validator: locals.validator
            errors:
              username: [ 'String is empty' ]
              password: [ 'Values are not equal' ]

          render: 'form'

        done()

  describe ':)', ->

    it 'renders the form view and sets the errors and form_model locals', (done)->

      locals = validator: createLocalValidator(goodCredentials)

      recorder middleware('form') , { body, locals }, (result)->

        result.eql
          locals:
            validator: locals.validator
            validated_data: name: 'Geert', username: 'Pickels', password: '1234'

          next: [true]

        done()
