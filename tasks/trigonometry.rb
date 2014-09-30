require 'bigdecimal'

module Trigonometry
  extend self

  # Keeps only the last calculated factorial.
  class FactorialCache
    def initialize(base_factorial)
      @cache = base_factorial
    end

    def [](key)
      if !@cache[key]
        number, factorial = @cache.to_a.last
        @cache = {key => factorial * (number.next..key).reduce(:*)}
      end

      @cache[key]
    end
  end

  # Calculates the sine of an angle measured in radians with the specified precision.
  def sine(x, precision = 10)
    return -1 unless precision > 0

    sum = 0
    cache = FactorialCache.new(1 => 1)

    (0..precision).each do |k|
      power = 2*k + 1
      denominator = cache[power]

      sum += kth_term(x, k, power, denominator)
    end

    sum
  end

  # Calculates the cosine of an angle measured in radians with the specified precision.
  def cosine(x, precision = 10)
    return -1 unless precision > 0

    sum = 0
    cache = FactorialCache.new(0 => 1)

    (0..precision).each do |k|
      power = 2*k
      denominator = cache[power]

      sum += kth_term(x, k, power, denominator)
    end

    sum
  end

  private

  def kth_term(x, k, power, denominator)
    ((-1)**k * x**power) / denominator
  end
end

if __FILE__ == $0
  PI_THIRDS = BigDecimal(Math::PI / 3.0, 15)
  FIVE_PI_THIRDS = BigDecimal(5 * Math::PI / 3.0, 15)

  sin_radians = FIVE_PI_THIRDS
  cos_radians = PI_THIRDS
  precision = 200

  puts "sine of #{sin_radians} radians is #{Trigonometry.sine(sin_radians, precision)}"
  puts "and Math.sin says it's #{Math.sin(sin_radians)}"

  puts ''

  puts "cosine of #{cos_radians} radians is #{Trigonometry.cosine(cos_radians, precision)}"
  puts "and Math.cos says it's #{Math.cos(cos_radians)}"

end