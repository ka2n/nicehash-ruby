require "test_helper"

class Nicehash::VersionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Nicehash::VERSION
  end
end