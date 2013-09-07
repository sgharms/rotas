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
      @file_loader = RotasDefaultFileLoader.new(self) || opts[:file_loader].new(self)
      @lookup_table = RotasDefaultLookupTable.new(self) || opts[:lookup_table].new(self)
      @translator = RotasDefaultTranslator.new(@lookup_table, RotasDefaultOffsetStrategy.new)
    end

    def call(word_to_rotate)
      aggregator = []
      word_to_rotate.split('').each_slice(4) do |quartet_of_letters|
        aggregator << @translator.translate(quartet_of_letters)
      end
      aggregator
    end
  end
end
