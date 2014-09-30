module Factorial
  extend self

  def kth_factorial(k = 1, n)
    return -1 unless n > 0 && k > 0

    product = (1..n).reduce(:*)

    product ** k
  end

  # Courtesy of AcitveSupport::Inflector.ordinalize.
  def ordinal(number)
    if (11..13).include?(number.to_i.abs % 100)
      "#{number}th"
    else
      case number.to_i.abs % 10
        when 1; "#{number}st"
        when 2; "#{number}nd"
        when 3; "#{number}rd"
        else    "#{number}th"
      end
    end
  end
end

if __FILE__ == $0
  k = 122
  number = 5

  puts "#{Factorial.ordinal(k)} factorial of #{number} is #{Factorial.kth_factorial(k, number)}"
end