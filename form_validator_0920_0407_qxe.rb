# 代码生成时间: 2025-09-20 04:07:40
# FormValidator class is a simple validator for form data using Hanami::Validations
class FormValidator
  include Hanami::Validations

  # Define the attributes that need to be validated
  attributes :name, :email, :age

  # Validation rules
  
  # Ensures that name is present and not empty
  #
  # @example Valid name
  #   FormValidator.new(name: 'John Doe')
  #   # => #<FormValidator name: 'John Doe'>
  #
  # @example Invalid name (empty)
  #   FormValidator.new(name: '')
  #   # => #<FormValidator name: '', errors: #<Hanami::Validations::Errors> (empty)>
  validates :name, presence: true, message: 'Name cannot be empty'

  # Ensures that email is present, not empty and is in the correct format
  #
  # @example Valid email
  #   FormValidator.new(email: 'john@example.com')
  #   # => #<FormValidator email: 'john@example.com'>
  #
  # @example Invalid email (empty)
  #   FormValidator.new(email: '')
  #   # => #<FormValidator email: '', errors: #<Hanami::Validations::Errors> (invalid format)>
  #
  # @example Invalid email (invalid format)
  #   FormValidator.new(email: 'invalid_email')
  #   # => #<FormValidator email: 'invalid_email', errors: #<Hanami::Validations::Errors> (invalid format)>
  validates :email, presence: true, format: URI::MailTo::EMAIL_REGEXP, message: 'Email must be a valid email address'

  # Ensures that age is present and is a positive integer
  #
  # @example Valid age
  #   FormValidator.new(age: 30)
  #   # => #<FormValidator age: 30>
  #
  # @example Invalid age (not a number)
  #   FormValidator.new(age: 'thirty')
  #   # => #<FormValidator age: 'thirty', errors: #<Hanami::Validations::Errors> (not a number)>
  #
  # @example Invalid age (negative number)
  #   FormValidator.new(age: -10)
  #   # => #<FormValidator age: -10, errors: #<Hanami::Validations::Errors> (negative number)>
  validates :age, presence: true, type: Integer, minimum: 0, message: 'Age must be a non-negative integer'

  # Public: Initialize a new FormValidator instance with attributes
  #
  # attributes - A hash of attributes to validate
  #
  # @return [FormValidator] A new instance of FormValidator
  def initialize(attributes)
    super
    self.attributes = attributes
  end

  # Public: Check if the form data is valid
  #
  # @return [Boolean] True if the data is valid, false otherwise
  def valid?
    super
  end

  # Public: Get the errors of the form data
  #
  # @return [Hanami::Validations::Errors] The errors of the form data
  def errors
    @errors ||= Hanami::Validations::Errors.new(self.class, self.attributes.keys)
  end
end