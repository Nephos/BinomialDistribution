class TestBinomialDistribution < Test::Unit::TestCase

  def test_simple
    0.0.step(by: 0.1, to: 1.0) do |proba|
      assert_equal proba, Math.binomial_distribution(tries: 1, probability: proba, success: 1)
    end
  end

  def test_nonamed_arguments
    assert_equal 0.4, Math.binomial_distribution(tries: 1, probability: 0.4, success: 1)
    assert_equal 0.4, Math.binomial_distribution(1, probability: 0.4, success: 1)
    assert_equal 0.4, Math.binomial_distribution(1, tries: 1, probability: 0.4)
    assert_equal 0.4, Math.binomial_distribution(0.4, tries: 1, success: 1)
    assert_equal 0.4, Math.binomial_distribution(1, 0.4, success: 1)
    assert_equal 0.4, Math.binomial_distribution(0.4, 1, tries: 1)
    assert_equal 0.4, Math.binomial_distribution(1, 0.4, 1)
    assert_equal 0.4, Math.binomial_distribution(1, 1, probability: 0.4)
  end

  def test_enum
    t3 = Math.binomial_distribution(tries: 10, probability: 0.1, success: 3)
    t2 = Math.binomial_distribution(tries: 10, probability: 0.1, success: 2)
    t1 = Math.binomial_distribution(tries: 10, probability: 0.1, success: 1)
    tt = Math.binomial_distribution(tries: 10, probability: 0.1, success: [1,2,3])
    assert_equal t3 + t2 + t1, tt
  end

end
