require 'minitest/autorun'
require 'minitest/pride'
require 'rotas/default_file_loader'
require 'ostruct'


class DefaultFileLoaderTest < Minitest::Unit::TestCase

  def test_alternate_definition_file_can_be_injected
    stub_app = OpenStruct.new({
      source_file: 'mock',
      options: {option1: 'value 1'}
    })
    loader = RotasDefaultFileLoader.new(stub_app)
    assert_equal loader.config_yaml_source, 'mock', "File path should be injectable"
  end

  def test_default_source_file_is_defaulted_to
    stub_app = OpenStruct.new({
      source_file: nil,
      options: {disallow_user_config: true}
    })
    loader = RotasDefaultFileLoader.new(stub_app)
    refute_equal loader.config_yaml_source, 'mock', "File path should be injectable"
    assert_match(/yml$/, loader.config_yaml_source, "Default file path should end in YML")
    assert_equal "Locus for Z", loader.config_yaml.last["locus"], "When forced to use default config, last record's locus should be 'Locus for Z'"
  end

end
