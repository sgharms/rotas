require 'minitest/autorun'
require 'minitest/pride'
require 'ostruct'
require 'rotas/default_lookup_table'

class LookuptableTest < Minitest::Unit::TestCase

  def test_basic

    yaml_sample =<<-EOYAML
      -
        letter: W
        subject: "Subject for W"
        verb: "Verb for W"
        implement: "Implement for W"
        locus: "Locus for W"
    EOYAML
    deserialized_yaml_sample = YAML.load(yaml_sample)
    table = RotasDefaultLookupTable.new(deserialized_yaml_sample)
    assert table.respond_to?(:[]), "Should delegate to the internal struct"
    assert_match(/Locus/, table['W'].locus, "Should delegate to stubbed YAML data")
  end

end
