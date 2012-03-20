module.exports = (view)->

  (req, res, next)->

    validator = res.locals().validator

    validator.validate
      
      valid: (data)->

        res.local 'validated_data', data

        next()

      invalid: (errors)->

        res.local 'form_model', req.body
        res.local 'errors', errors
        res.render view
