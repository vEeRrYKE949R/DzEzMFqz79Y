# 代码生成时间: 2025-09-23 06:17:13
# math_toolbox.rb
# A mathematical toolbox implemented in Ruby using the Hanami framework
# Provides a set of basic mathematical operations

require 'hanami'
require 'hanami/controller'
require 'hanami/validations'
require 'hanami/interactor'

module MathToolbox
  # ValidationError is used to handle validation errors
  class ValidationError < StandardError; end

  # OperationResult is a simple struct to hold operation results
  OperationResult = Struct.new(:success, :result)

  # OperationValidator handles input validation
  class OperationValidator
    include Hanami::Validations
    validation do
      required(:operand1).filled
      required(:operand2).filled
    end
  end

  # Interactor for performing mathematical operations
  class PerformOperation
    include Hanami::Interactor
    include OperationValidator
    def call(operand1, operand2, operation)
      validate(operand1: operand1, operand2: operand2)
      validate_operation(operation)
      result = perform_operation(operand1, operand2, operation)
      OperationResult.new(true, result)
    rescue ValidationError => e
      OperationResult.new(false, e.message)
    end

    private
    def validate_operation(operation)
      unless %i[add subtract multiply divide].include?(operation)
        fail ValidationError, 'Invalid operation'
      end
    end

    def perform_operation(operand1, operand2, operation)
      public_send(operation, operand1, operand2)
    end

    def add(operand1, operand2)
      operand1 + operand2
    end

    def subtract(operand1, operand2)
      operand1 - operand2
    end

    def multiply(operand1, operand2)
      operand1 * operand2
    end

    def divide(operand1, operand2)
      fail ValidationError, 'Division by zero' if operand2.zero?
      operand1.to_f / operand2
    end
  end

  # Controller for handling HTTP requests
  class MathController < Hanami::Controller
    def calculate(params)
      operation = params.fetch(:operation).to_sym
      operand1 = params.fetch(:operand1).to_f
      operand2 = params.fetch(:operand2).to_f
      result = PerformOperation.call(operand1, operand2, operation)
      if result.success
        json_response(result.result)
      else
        json_response({ error: result.result }, status: 400)
      end
    end

    private
    def json_response(data, status: 200)
      self.body = data.to_json
      self.status = status
    end
  end
end