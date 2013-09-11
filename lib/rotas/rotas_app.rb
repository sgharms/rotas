require 'yaml'
require 'forwardable'

module Rotas
  class RotasApp
    extend ::Forwardable
    def_delegator :@file_loader, :config_yaml, :config

    attr_reader :source_file, :options

    def initialize(opts={translator: nil, file_loader: nil})
      @options = opts
      @file_loader = opts[:file_loader]
      @translator = opts[:translator]
      @sectioner = (opts[:sectioner_class] || RotasDefaultLetterCelDivider).new
      check_params!
    end

    def call(word_to_rotate)
      @sectioner.call(word_to_rotate).map do |quartet_of_letters|
        @translator.translate(quartet_of_letters)
      end
    end

    private

    def check_params!
      required_conditions = @options[:translator] && @options[:file_loader]
      return if required_conditions
      raise <<-EOERROR

  1.  RotasApp must be provided a :file_loader and an :translator option

  2.  The :file_loader object must respond to `config_yaml` which returns
      a loaded rotas configuration file.
      EOERROR
    end
  end
end
