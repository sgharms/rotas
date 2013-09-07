class RotasDefaultTranslator
  WHEEL_NAMES =  [:subject, :verb, :implement, :locus]
  NUMBER_OF_WHEELS = 4

  def initialize(lookup_table, offset_annotation_strategy=nil)
    @lookup_table = lookup_table
    @offsetter = offset_annotation_strategy
  end

  def translate(letter_set)
    result = []

    token_index = 0

    while letter_set.length < NUMBER_OF_WHEELS do
      letter_set << ""
    end

    letter_set.each do |letter|
      if letter.match(/[A-Za-z]/) && token_index <= WHEEL_NAMES.length
        result << @offsetter.call(@lookup_table[letter.upcase].send(WHEEL_NAMES[token_index]))
        token_index += 1
      else
        result << letter
      end
    end

    @offsetter.format_line(result)
  end

end
