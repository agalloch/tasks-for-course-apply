class Quaternion
  def initialize(default)
    @q = default
  end

  def [](component)
    @q[component] ? @q[component] : 0
  end

  def +(other)
    Quaternion.new(e: self[:e] + other[:e], i: self[:i] + other[:i], j: self[:j] + other[:j], k: self[:k] + other[:k])
  end

  def conjugate
    Quaternion.new(e: self[:e], i: -self[:i], j: -self[:j], k: -self[:k])
  end

  def to_s
    "#{self.class}: (#{self[:e]}, #{self[:i]}*i, #{self[:j]}*j, #{self[:k]}*k)"
  end
end

if __FILE__ == $0
  q1 = Quaternion.new(e: 1, i: 6, k: 1)
  q2 = Quaternion.new(e: 1, i: 5, j: 1, k: 1)

  p (q1 + q2)
  p q1.conjugate
end
