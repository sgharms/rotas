require 'rotas/wheel_elements/wheel_element'

class NullWheelElement < WheelElement
  def initialize()
    @letter = nil
    @subject = nil
    @verb = nil
    @implement = nil
    @locus = nil
  end
end
