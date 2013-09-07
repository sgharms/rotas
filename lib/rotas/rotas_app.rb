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
      @translator = RotasDefaultTranslator.new
      @offset_strategy = RotasDefaultOffsetStrategy.new
    end

    def call(word_to_rotate)
      aggregator = []
      word_to_rotate.split('').each_slice(4) do |quartet_of_letters|
        aggregator << translate_group(quartet_of_letters)
      end
      aggregator
    end

    private

    def translate_group(quartet_of_letters)
      while quartet_of_letters.length < 4 do
        quartet_of_letters << ""
      end
      subject, verb, implement, locus = quartet_of_letters
      result = []
      result << offsetter(@lookup_table[subject.upcase].subject)
      result << offsetter(@lookup_table[verb.upcase].verb)
      result << offsetter(@lookup_table[implement.upcase].implement)
      result << offsetter(@lookup_table[locus.upcase].locus)
      format_line(result)
    end

    def offsetter(token)
      return "" if token == ""
      sprintf("[%s]", token)
    end

    def format_line(four_tokens)
      line = ""
      line += four_tokens[0] if four_tokens[0] != ""
      line += " " if four_tokens[1] != ""
      line += four_tokens[1] if four_tokens[1] != ""
      line += " with #{a_or_an(four_tokens[2])} #{four_tokens[2]}" if four_tokens[2] != ""
      line += " in #{a_or_an(four_tokens[3])} #{four_tokens[3]}" if four_tokens[3] != ""
      line += "." if four_tokens[3] != ""
      line
    end

    def a_or_an(word)
      %w/a e i o u/.include?(word[0].downcase) ? 'an' : 'a'
    end

  end
end
