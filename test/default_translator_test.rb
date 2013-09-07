require 'minitest/autorun'
require 'minitest/pride'
require 'rotas/null_offsetter'
require 'ostruct'


class DefaultTranslatorTest < Minitest::Unit::TestCase

  def test_basic
    stub_table = OpenStruct.new({
      T: OpenStruct.new({
      subject: 'Stub T',
      verb: 'Stub T',
      implement: 'Stub T',
      locus: 'Stub T'
    }),
      E: OpenStruct.new({
      subject: 'Stub E',
      verb: 'Stub E',
      implement: 'Stub E',
      locus: 'Stub E'
    }),
      S: OpenStruct.new({
      subject: 'Stub S',
      verb: 'Stub S',
      implement: 'Stub S',
      locus: 'Stub S'
    }),
    })
    stub_offsetter = ::RotasNullOffsetter.new
    translator =  RotasDefaultTranslator.new(stub_table, stub_offsetter)
    translator.translate("test".split(''))
  end

end
