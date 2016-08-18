module Math

  def self.factorial(n)
    raise ArgumentError, 'The argument muse be a natural Fixnum N' if not n.is_a? Fixnum
    raise Math::DomainError, 'The argument must be a natural (out of domain -- factorial)' if n < 0
    return 1 if n.zero?
    return (1..n).inject(:*)
  end unless self.method_defined? :factorial

  def self.coef_binomial(n, k)
    return 0 if n < 0 or k < 0 or n < k
    return factorial(n) / (factorial(k) * factorial(n - k))
  end

  # @note if no named parameters are used, then it will try to use the unamed parameters (tries, success, probability)
  def self.binomial_distribution(*unamed, tries: nil, success: nil, probability: nil)
    unamed.reverse! # pop works on a stack
    Binomial.new(tries: tries || unamed.pop, probability: probability || unamed.pop).distribute(success || unamed.pop)
  end

  class SuperiorityError < Exception; end
end

class Array
  def second
    self[1]
  end unless self.method_defined? :second
end

class Binomial

  # @param n [Fixnum] number of tries
  # @param p [Float] probability of success
  # @param tries [Fixnum] alias for n
  # @param probability [Float] alias for p
  # @param failure [Float] alias for `p = 1 - failure`
  # @note if no probability is defined, the default value will be 0.5
  def initialize n: nil, p: nil, tries: nil, probability: nil, failure: nil
    tries_count = n || tries
    probability = p || probability || (failure && 1.0 - failure) || 0.5
    raise ArgumentError, "The argument `n` `#{tries_count}` is not an Integer" unless tries_count.is_a? Integer
    raise ArgumentError, "The argument `p` `#{probability}` is not a Numeric" unless probability.is_a? Numeric
    tries_count = Float(tries_count)
    raise Math::DomainError, "The argument `n` `#{tries_count}` is not in greater or equal to 0" if tries_count < 0.0
    raise Math::DomainError, "The argument `p` `#{probability}` is not in greater or equal to 0" if probability < 0.0
    raise Math::DomainError, "The argument `p` `#{probability}` is not in lesser or equal to 1" if probability > 1.0
    @n = tries_count.to_i
    @p = probability.to_f
  end

  def to_s
    "#<#{self.class} @n=#@n, @p=#@p>"
  end

  # @param k [Fixnum] number of test successful.
  # @param k [Enumerable] list of number of test successful.
  # @return [Float] probability
  def distribute k
    if k.is_a? Enumerable
      distribute_enumerable k
    elsif k.is_a? Integer
      distribute_integer k
    else
      raise ArgumentError
    end
  end

  private def distribute_enumerable k
    k.map{|p| distribute_integer(p) }.reduce(&:+)
  end

  private def distribute_integer k
    raise Math::SuperiorityError, "the number of success must be lesser or equal to the number of tries (#{@n})" if k > @n
    Math.coef_binomial(@n, k) * @p**k * (1 - @p) ** (@n - k)
  end

end

#
# if __FILE__ == $0
#   require 'pry'
#   binding.pry
# end
