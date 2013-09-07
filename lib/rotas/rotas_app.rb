require 'yaml'
require 'forwardable'

module Rotas
  class RotasApp
    SECTION_BY = 4

    extend ::Forwardable
    def_delegator :@file_loader, :config_yaml, :config

    attr_reader :source_file, :options

    def initialize(source_file=nil, opts={})
      @options = opts
      @source_file = source_file
      @file_loader = RotasDefaultFileLoader.new(self) || opts[:file_loader].new(self)
      lookup_table = RotasDefaultLookupTable.new(self) || opts[:lookup_table].new(self)
      offset_strategy = RotasDefaultOffsetStrategy.new || opts[:offset_strategy].new
      translator_class = RotasDefaultTranslator || opts[:translator_class]
      @translator = translator_class.new(lookup_table, offset_strategy)
      @sectioner = RotasDefaultLetterCelDivider.new(SECTION_BY)
    end

    def call(word_to_rotate)
      @sectioner.call(word_to_rotate).map do |quartet_of_letters|
        @translator.translate(quartet_of_letters)
      end
    end
  end
end
