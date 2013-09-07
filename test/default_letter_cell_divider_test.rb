require 'minitest/autorun'
require 'minitest/pride'
require "rotas/default_letter_cel_divider"

class DefaultLetterCelDividerTest < Minitest::Unit::TestCase

  def test_quadrenary_sectioning
    group_count = 0
    RotasDefaultLetterCelDivider.new(4).call('eightyay').each{ |g| group_count += 1 }
    assert_equal 2, group_count, "Should divide into 2 groups"
  end

  def test_ternary_sectioning
    group_count = 0
    RotasDefaultLetterCelDivider.new(3).call('foobar').each{ |g| group_count += 1 }
    assert_equal 2, group_count, "Should divide into 2 groups"
  end
end
