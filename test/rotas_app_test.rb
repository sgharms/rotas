require 'minitest/autorun'
require 'minitest/pride'
require 'rotas'

class RotasAppTest < Minitest::Unit::TestCase
  def test_lines_with_non_translatable_characters
    file =  File.join(File.dirname(__FILE__), 'data', 'test_rotas.yml')
    conf = OpenStruct.new({source_file: file, options: {disallow_user_config: true}})
    rotas_config_file_loader = RotasDefaultFileLoader.new(conf)
    lookup_table = RotasDefaultLookupTable.new(rotas_config_file_loader.config_yaml)
    offset_strategy = RotasDefaultOffsetStrategy.new
    rotas_translator = RotasDefaultTranslator.new(lookup_table, offset_strategy)
    app = Rotas::RotasApp.new(file_loader: rotas_config_file_loader, translator: rotas_translator)
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
