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

  def coordinates
    @q.values
  end

  def -@
    Quaternion.new(*coordinates.map { |coord| coord * (-1) })
  end

  def +(other)
    Quaternion.new(*coordinates.zip(other.coordinates).map { |item| item.first + item.last})
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
    Quaternion.new(*@q.map { |k, v| (k == :e) ? v : v * (-1) })
  end

  def norm
    Math.sqrt(coordinates.map { |coord| coord**2 }.reduce(0, :+))
  end

  def to_s
    formatted_coordinates = @q.map { |k, v| "#{v}#{v.zero? ? '' : k}" }.join(', ')

    "#{self.class}: (#{formatted_coordinates})"
  end
end


if __FILE__ == $0
  q1 = Quaternion.new(1, 0, 6, 1)
  q2 = Quaternion.new(1, 5, 1, 1)

  q_e = Quaternion.new(1, 0, 0, 0)
  q_i = Quaternion.new(0, 1, 0, 0)
  q_j = Quaternion.new(0, 0, 1, 0)
  q_k = Quaternion.new(0, 0, 0, 1)

  puts "ij == #{q_i * q_j} == -#{q_j * q_i}"
  puts "jk == #{q_j * q_k} == -#{q_k * q_j}"
  puts "ki == #{q_k * q_i} == -#{q_i * q_k}"

  puts "identity for i #{q_i * q_e} is the same as #{q_e * q_i}"
  puts "identity for j #{q_j * q_e} is the same as #{q_e * q_j}"
  puts "identity for k #{q_k * q_e} is the same as #{q_e * q_k}"

  p q1 + q2
  p q1 - q2
  p (q1 - q2).norm

  p q1.conjugate

  p q1 * q2
  p q2 * q1
end
