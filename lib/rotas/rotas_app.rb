require 'yaml'
require 'forwardable'

module Rotas
  class RotasApp
    extend ::Forwardable
    def_delegator :@file_loader, :config_yaml, :config

    attr_reader :source_file, :options

    def initialize(source_file=nil, opts={})
      @options = opts
      @source_file = source_file
      @file_loader = (opts[:file_loader_class] || RotasDefaultFileLoader).new(self)
      @translator = opts[:translator] || build_default_translator
      @sectioner = (opts[:sectioner_class] || RotasDefaultLetterCelDivider).new
    end

    def call(word_to_rotate)
      @sectioner.call(word_to_rotate).map do |quartet_of_letters|
        @translator.translate(quartet_of_letters)
      end
    end

    private

    def build_default_translator
      lookup_table = RotasDefaultLookupTable.new(@file_loader.config_yaml)
      offset_strategy = RotasDefaultOffsetStrategy.new
      RotasDefaultTranslator.new(lookup_table, offset_strategy)
    end
  end
end
