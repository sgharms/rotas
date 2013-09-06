require 'minitest/autorun'
require 'minitest/pride'
require 'rotas'


class BasicTest < Minitest::Unit::TestCase
  def setup
  end

  def test_alternate_definition_file_can_be_injected
    file =  File.join(File.dirname(__FILE__), 'data', 'test_rotas.yml')
    app = Rotas::RotasApp.new(file)
    assert_equal file, app.source_file, "Data file should be the test data file."
    assert_equal app.call("test").first, test_file_result, "Running rotas on 'test' should be a simple sentence with filler values"
  end

  private

  def test_file_result
    "[Test subject for T] [Test verb for E] with a [Test implement for S] in a [Test locus for T]."
  end

end
