# 代码生成时间: 2025-09-23 18:03:40
#!/usr/bin/env ruby
# encoding: utf-8

require 'hanami'
require 'hanami/helpers'
require 'loofah'
require 'nokogiri'

# Hanami::Helpers::Tag is used for safe HTML generation
include Hanami::Helpers::Tag

# This class provides XSS protection by sanitizing input
class XssProtection
  # Sanitize input to prevent XSS attacks
  #
  # @param input [String] The raw input to be sanitized
  # @return [String] The sanitized input
  def self.sanitize(input)
    # Use Loofah to sanitize the input
    sanitized_input = Loofah.fragment(input).scrub!(:prune).to_s
    # Use Nokogiri to remove any remaining potentially dangerous tags
    doc = Nokogiri::HTML.fragment(sanitized_input)
    doc.xpath('//*[not(self::img) and not(self::a)]').each(&:remove)
    doc.to_html
  end

  # Example usage of the sanitize method
  def self.example
    raw_input = "<script>alert('XSS')</script>"
    sanitized = sanitize(raw_input)
    puts "Raw Input: #{raw_input}"
    puts "Sanitized Input: #{sanitized}"
  end

  # Run the example if the script is executed directly
  example if __FILE__ == $0
end