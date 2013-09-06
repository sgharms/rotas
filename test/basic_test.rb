require 'minitest/autorun'
require 'minitest/pride'


class BasicTest < Minitest::Unit::TestCase
  def setup
    puts 'hi setup'
  end

  def test_basic
    assert true, 'is true'
  end
end
