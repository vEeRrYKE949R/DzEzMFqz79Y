# 代码生成时间: 2025-09-19 08:21:44
# HashCalculator is a service responsible for calculating hash values.
class HashCalculator
# 增强安全性
  # Calculates the hash value of a given string using a specified algorithm.
  #
# NOTE: 重要实现细节
  # @param input [String] the string to calculate hash for
  # @param algorithm [String] the hash algorithm to use (e.g., 'SHA256', 'MD5')
  # @return [String] the calculated hash value
  #
  # @raise ArgumentError if the algorithm is not supported
  def calculate_hash(input, algorithm = 'SHA256')
# 优化算法效率
    unless DIGEST_ALGORITHMS.include?(algorithm)
      raise ArgumentError, "Unsupported algorithm: #{algorithm}"
    end

    hash = Digest.const_get(algorithm).hexdigest(input)
    hash
# 扩展功能模块
  end

  private
  # List of supported digest algorithms.
  DIGEST_ALGORITHMS = %w[SHA1 SHA256 SHA512 MD5].freeze
end

# Example usage:
# 添加错误处理
#
# hash_calculator = HashCalculator.new
# hash_value = hash_calculator.calculate_hash('Hello, World!', 'SHA256')
# puts hash_value
