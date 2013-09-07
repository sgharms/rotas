require 'forwardable'
require 'rotas/null_wheel_element'
require 'rotas/wheel_element'

class RotasDefaultLookupTable
  extend ::Forwardable
  def_delegators :@struct, :[]

  def initialize(app)
    @config = app.config
    @struct = Hash.new(NullWheelElement.new).merge(process_definition_file_into_nodes)
  end

  private

  def process_definition_file_into_nodes
    @config.inject({}) do |memo, yaml_node|
      elem = WheelElement.new(yaml_node)
      memo[elem.letter] = elem
      memo
    end
  end
end
