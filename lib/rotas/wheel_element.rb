class WheelElement
  attr_reader :letter, :subject, :verb, :implement, :locus

  def initialize(keyed_enumerable)
    keyed_enumerable.keys.each do |key|
      instance_variable_set "@#{key}".to_sym, keyed_enumerable[key]
    end
  end
end
