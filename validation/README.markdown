# Square Validation

## Validators

The api for a validator looks like:

``` coffee-script
required: (msg)->

  (data, invalid, valid)->

    try
      check(data, msg).notEmpty()
    catch e
      return invalid e.message

    valid data
```

Function that returns a function that takes the data to validate and two callbacks. If the data is invalid call invalid with the error message. If the data is valid call valid with the (sanitized) data.

## Create

``` coffee-script
{ required, string, integer, email } = require( 'square-validator' ).validators
{ create } = require 'square-validator'

# Validation Map

user = create
  name: [ required(), string() ]
  age:  [ integer() ]
  email: [ required(), email() ]
  password: [ required() ]

# Remove fields you don't need 

sanitize = password: false

# Create user

User = create user, sanitize

# Instantiate user with data

geert = User name: 'Geert', age: 29, email: 'geert.pasteels@gmail.com', password: '1234'

# If valid it will call valid if not it will call invalid

geert.validate

  valid: (data)->
    # data is sanitized data

  invalid: (errors)->
    # Errors is an object with keys and an array of error(s)
```

## Middleware

Middleware to use with express. The middleware expects the validator at locals().validator.

``` coffee-script
{ create, middleware, validators } = require( 'square-validator' )
{ required, string, integer, email } =  validators

# Define your validator in a middleware

createValidator = (req, res, next)->

  user = create
    name: [ required(), string() ]
    age:  [ integer() ]
    email: [ required(), email() ]
    password: [ required() ]

  # Remove fields you don't need 

  sanitize = password: false

  # Create user

  User = create user, sanitize

  res.local 'validator', ( User req.body )

  next()

# Your route might look like the following: 

app.get '/', createValidator, middleware('error_view'), ...

```
If the data is invalid it will render error_view with the local errors and return the req.body as the local form_model. If the data is valid next will be called and the local validated_data will be set with your sanitized data.

## Run tests

Tests use mocha and should.

``` shell
make unittests
```
