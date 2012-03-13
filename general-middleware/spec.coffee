{ redirect, render, send } = require './src'
recorder = require('express-recorder').middleware

describe 'Redirect', ->

  it 'redirects to root', (done)->

    handler = redirect 'root'

    recorder handler, (result)->

      result.eql redirect: 'root'

      done()


describe 'Render', ->

  it 'renders my/profile/edit', (done)->

    handler = render 'my/profile/edit'

    recorder handler, (result)->

      result.eql render: 'my/profile/edit'

      done()


describe 'Send', ->

  it 'sends Never gonna give you up', (done)->

    handler = send 'Never gonna give you up'

    recorder handler, (result)->

      result.eql send: 'Never gonna give you up'

      done()
