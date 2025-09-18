# 代码生成时间: 2025-09-18 19:08:21
# hash_calculator.rb
#
# Hash Calculator Tool using Ruby and Hanami Framework
#
# @author Your Name
# @version 1.0
#

require 'digest'
require 'hanami'

class HashCalculator
  # Calculate the hash for the given input
  #
  # @param [String] input The input string to calculate the hash
  # @param [Symbol] algorithm The hash algorithm to use (e.g., :sha256)
  # @return [String] The calculated hash
  def calculate_hash(input, algorithm = :sha256)
    unless Digest::Digest.constants.include?(:"#{algorithm.to_s.upcase}")
      raise ArgumentError, "Unsupported algorithm: #{algorithm}"
    end

    Digest::Digest.const_get(algorithm.to_s.upcase).hexdigest(input)
  end

  # Verify if the calculated hash matches the original hash
  #
  # @param [String] input The input string to verify
  # @param [String] original_hash The original hash to compare with
  # @param [Symbol] algorithm The hash algorithm used to calculate the original hash
  # @return [Boolean] True if the hashes match, false otherwise
  def verify_hash?(input, original_hash, algorithm = :sha256)
    calculated_hash = calculate_hash(input, algorithm)
    calculated_hash == original_hash
  end
end

# Usage example
if __FILE__ == $0
  calculator = HashCalculator.new
  input = 'Hello, World!'
  algorithm = :sha256

  begin
    hash = calculator.calculate_hash(input, algorithm)
    puts "The hash for '#{input}' using #{algorithm} is: #{hash}"

    original_hash = hash
    puts 'Verification result:' if calculator.verify_hash?(input, original_hash, algorithm)
  rescue ArgumentError => e
    puts e.message
  end
end