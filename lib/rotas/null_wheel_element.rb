require 'rotas/wheel_element'

class NullWheelElement < WheelElement
  def initialize()
    @letter = ""
    @subject = ""
    @verb = ""
    @implement = ""
    @locus = ""
  end
end
