require 'forwardable'
require 'rotas/wheel_elements/null_wheel_element'
require 'rotas/wheel_elements/wheel_element'

class RotasDefaultLookupTable
  extend ::Forwardable
  def_delegators :@struct, :[]

  def initialize(yaml)
    @rotas_definition_as_yaml = yaml
    @struct = Hash.new(NullWheelElement.new).merge(process_definition_file_into_nodes)
  end

  private

  def process_definition_file_into_nodes
    @rotas_definition_as_yaml.inject({}) do |memo, yaml_node|
      elem = WheelElement.new(yaml_node)
      memo[elem.letter] = elem
      memo
    end
  end
end
