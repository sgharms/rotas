require 'minitest/autorun'
require 'minitest/pride'
require "rotas/default_letter_cel_divider"

class DefaultLetterCelDividerTest < Minitest::Unit::TestCase

  def test_quadrenary_sectioning
    divider = RotasDefaultLetterCelDivider.new(4).call('eightyay')
    assert_equal 2, divider.length, "Should divide into 2 groups"
  end

  def test_ternary_sectioning
    divider = RotasDefaultLetterCelDivider.new(3).call('foobar')
    assert_equal 2, divider.length, "Should divide into 2 groups"
  end

  def test_quadrenary_sectioning_with_nontranslatable_chars
    divider = RotasDefaultLetterCelDivider.new(3).call('foo / bar')
    assert_equal 2, divider.length, "Should divide into 2 groups"
  end
end
