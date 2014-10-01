class Quaternion
  def initialize(e, i, j, k)
    @q = {e: e, i: i, j: j, k: k}
  end

  def [](component)
    @q[component] ? @q[component] : 0
  end

  def []=(key, value)
    @q[key] = value
  end

  def -@
    Quaternion.new(-self[:e], -self[:i], -self[:j], -self[:k])
  end

  def +(other)
    Quaternion.new(self[:e] + other[:e],
      self[:i] + other[:i],
      self[:j] + other[:j],
      self[:k] + other[:k])
  end

  def -(other)
    self + (-other)
  end

  def *(other)
    Quaternion.new(self[:e] * other[:e] - self[:i] * other[:i] - self[:j] * other[:j] - self[:k] * other[:k],
      self[:e] * other[:i] + self[:i] * other[:e] + self[:j] * other[:k] - self[:k] * other[:j],
      self[:e] * other[:j] - self[:i] * other[:k] + self[:j] * other[:e] + self[:k] * other[:i],
      self[:e] * other[:k] + self[:i] * other[:j] - self[:j] * other[:i] + self[:k] * other[:e])
  end

  def conjugate
    Quaternion.new(self[:e], -self[:i], -self[:j], -self[:k])
  end

  def norm
    Math.sqrt(self[:e]**2 + self[:i]**2 + self[:j]**2 + self[:k]**2)
  end

  def to_s
    "#{self.class}: (#{self[:e]}, #{self[:i]}*i, #{self[:j]}*j, #{self[:k]}*k)"
  end
end


if __FILE__ == $0
  q1 = Quaternion.new(1, 0, 6, 1)
  q2 = Quaternion.new(1, 5, 1, 1)

  p q1 + q2
  p q1.conjugate
  q1[:j] = 67
  puts "#{q1} norm = #{q1.norm}"

  p q1 - q2
  p q1 * q2
  p q2 * q1
end
