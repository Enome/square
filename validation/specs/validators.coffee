{ required, integer, string, email, compare, decimal } = require '../src/validators'
should = require 'should'

describe 'Validators', ->


  describe 'Required', ->

    describe ':(', ->

      it 'returns String is empty error', ->

        required() '', (error)->

          error.should.eql 'String is empty'

      it 'returns a custom error', ->

        required('ooga booga') '',  (error)->

          error.should.eql 'ooga booga'

    describe ':)', ->

      it 'returns the string', ->

        required() 'Hello? Yes, this is done.', null, (data)->

          data.should.eql 'Hello? Yes, this is done.'


    describe 'Integer', ->

      describe ':(', ->

        it 'returns Invalid integer', ->

          integer() 'foo', (error)->

            error.should.eql 'Invalid integer'

        it 'returns a custom error', ->

          integer('ooga booga') 'foo', (error)->

            error.should.eql 'ooga booga'

      describe ':)', ->

        it 'returns sanitized integer', ->

          integer() '15', null, (data)->

            data.should.eql 15

        it 'returns undefined if the value is undefined', ->

          integer() undefined, null, (data)->

            should.not.exist data


  describe 'string', ->

    describe ':)', ->

      it 'returns the sanitized string', ->

        string() 15, null, (data)->

          data.should.eql '15'
      
      it 'returns undefined if the value is undefined', ->

        string() undefined, null, (data)->

          should.not.exist data


  describe 'email', ->

    describe ':(', ->

      it 'returns Invalid email', ->

        email() 'geert.pasteels.com', (error)->

          error.should.eql 'Invalid email'

      it 'returns custom error', ->

        email('heyooo') 'geert.com', (error)->

          error.should.eql 'heyooo'

    describe ':)', ->

      it 'returns the email', ->

        email() 'geert.pasteels@gmail.com', null, (data)->

          data.should.eql 'geert.pasteels@gmail.com'


  describe 'compare', ->

    describe ':(', ->

      it 'returns Values are not equal', ->

        compare() ['test', 'test2'], (error)->

          error.should.eql 'Values are not equal'

      it 'returns custom error', ->

        compare('custom error') [1,2], (error)->

          error.should.eql 'custom error'

    describe ':)', ->

      it 'returns the array', ->

        compare() ['test', 'test'], null, (data)->

          data.should.eql 'test'


  describe 'decimal', ->

    describe ':(', ->

      it 'returns invalid decimal', ->

        decimal() '14.oo', (error)->

          error.should.eql 'Invalid decimal'

      it 'returns custom error', ->

        decimal('custom error') '14.oo', (error)->

          error.should.eql 'custom error'

    describe ':)', ->

      it 'returns the sanitized decimal', ->

        decimal() '14.99', null, (data)->

          data.should.eql '14.99'
