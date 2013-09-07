class RotasDefaultTranslator
  def initialize(lookup_table, offset_annotation_strategy=nil)
    @lookup_table = lookup_table
    @offsetter = offset_annotation_strategy
  end

  def translate(quartet_of_letters)
    while quartet_of_letters.length < 4 do
      quartet_of_letters << ""
    end
    subject, verb, implement, locus = quartet_of_letters
    result = []
    result << @offsetter.call(@lookup_table[subject.upcase].subject)
    result << @offsetter.call(@lookup_table[verb.upcase].verb)
    result << @offsetter.call(@lookup_table[implement.upcase].implement)
    result << @offsetter.call(@lookup_table[locus.upcase].locus)
    @offsetter.format_line(result)
  end

end
