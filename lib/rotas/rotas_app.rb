require 'yaml'

module Rotas
  class RotasApp
    def initialize(source_file=nil)
      @source_file = source_file
    end

    def call(word_to_rotate)
      load_definition_file
      @lookup_table = Hash.new(NullWheelElement.new).merge(process_definition_file_into_nodes)

      word_to_rotate.split('').each_slice(4) do |quartet_of_letters|
        translate_group(quartet_of_letters)
      end
    end

    private

    def load_definition_file
      source = @source_file || personal_rotas_file || factory_default_rotas_file
      puts "using #{source}"
      @yaml_tree = YAML.load_file(source)
    rescue => e
      puts "Rotas could not load a data file: #{e.message}"
    end

    def factory_default_rotas_file
      default_config_file_path = File.join(File.dirname(__FILE__), '..', '..',  *%w/data rotas.yml/)
      return default_config_file_path if File.exists?(default_config_file_path)
    end

    def personal_rotas_file
      personal_rotas_file = File.join(ENV['HOME'], ".rotas.yml")
      return personal_rotas_file if File.exists?(personal_rotas_file)
      false
    end

    def process_definition_file_into_nodes
      @yaml_tree.inject({}) do |memo, yaml_node|
        elem = WheelElement.new(yaml_node)
        memo[elem.letter] = elem
        memo
      end
    end

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
      puts format_line(result)
    end

    def offsetter(token)
      sprintf "[%s]", token
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
