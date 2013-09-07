require 'minitest/autorun'
require 'minitest/pride'
require 'rotas'

class RotasAppTest < Minitest::Unit::TestCase

  def test_alternate_definition_file_can_be_injected
    file =  File.join(File.dirname(__FILE__), 'data', 'test_rotas.yml')
    app = Rotas::RotasApp.new(file)
    assert_equal file, app.source_file, "Data file should be the test data file."
    assert_equal test_file_result, app.call("test").first, "Running rotas on 'test' should be a simple sentence with filler values"
  end

  def test_app_uses_default_definition_file_by_default_prohibit_user_config
    app = Rotas::RotasApp.new(nil, disallow_user_config: true)
    assert app.config, "App should be able to share a non-empty config by default"
    assert_equal "Locus for Z", app.config.last["locus"], "When forced to use default config, last record's locus should be 'Locus for Z'"
  end

  def test_lines_with_non_translatable_characters
    file =  File.join(File.dirname(__FILE__), 'data', 'test_rotas.yml')
    app = Rotas::RotasApp.new(file)
    assert_equal file, app.source_file, "Data file should be the test data file."
    assert_equal test_file_result2, app.call("me / myself").first, "Running rotas on 'me / myself' should be a simple sentence with filler values"
  end

  private

  def test_file_result
    "[Test subject for T] [Test verb for E] with a [Test implement for S] in/on a [Test locus for T]."
  end

  def test_file_result2
    "[Test subject for M] [Test verb for E] / with a [Test implement for M] in/on a [Test locus for Y]."
  end

end
