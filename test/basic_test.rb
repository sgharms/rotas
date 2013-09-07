require 'minitest/autorun'
require 'minitest/pride'
require 'rotas'

class BasicTest < Minitest::Unit::TestCase

  def test_alternate_definition_file_can_be_injected
    file =  File.join(File.dirname(__FILE__), 'data', 'test_rotas.yml')
    app = Rotas::RotasApp.new(file)
    assert_equal file, app.source_file, "Data file should be the test data file."
    assert_equal app.call("test").first, test_file_result, "Running rotas on 'test' should be a simple sentence with filler values"
  end

  def test_app_uses_default_definition_file_by_default_prohibit_user_config
    app = Rotas::RotasApp.new(nil, disallow_user_config: true)
    assert app.config, "App should be able to share a non-empty config by default"
    assert_equal app.config.last["locus"], "Locus for Z", "When forced to use default config, last record's locus should be 'Locus for Z'"
  end

  private

  def test_file_result
    "[Test subject for T] [Test verb for E] with a [Test implement for S] in a [Test locus for T]."
  end

end
