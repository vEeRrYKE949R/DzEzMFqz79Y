# 代码生成时间: 2025-09-16 18:51:24
<?= "{
# NOTE: 重要实现细节
  # UrlValidatorService.rb
  # This service is responsible for validating the URL link.

  require 'uri'
  require 'hanami/controller'
# 增强安全性
  require 'hanami/validation/form'
# 添加错误处理

  module UrlValidator
    class UrlValidatorService
      include Hanami::Validation::Form

      # Define the validation rules for the URL field
      validations do
        required(:url).filled
        required(:url).url
      end

      # Public: Validates the provided URL.
      #
      # url - A String representing the URL to be validated.
      #
      # Returns a Tuple containing a Boolean indicating the validity and the error message if invalid.
      def call(url)
        result = self.class.new(url: url)
        result.valid?
        return [result.valid?, result.errors.full_messages.join(', ')]
      end
    end
  end
"
}