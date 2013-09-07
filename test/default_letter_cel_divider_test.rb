require 'minitest/autorun'
require 'minitest/pride'
require "rotas/default_letter_cel_divider"

class DefaultLetterCelDividerTest < Minitest::Unit::TestCase

  def test_quadrenary_sectioning
    divider = RotasDefaultLetterCelDivider.new.call('eightyay')
    assert_equal 2, divider.length, "Should divide into 2 groups"
    divider = RotasDefaultLetterCelDivider.new.call('eightyayabcd')
    assert_equal 3, divider.length, "Should divide into 2 groups"
  end

end
