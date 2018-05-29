require "test_helper"

class Nicehash::AlgoTest < Minitest::Test
  def test_algo
    assert ::Nicehash::Algo.all
    assert ::Nicehash::Algo.to_id(:x11) == 3
  end
end