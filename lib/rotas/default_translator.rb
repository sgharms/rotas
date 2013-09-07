class DefaultTranslator
  def initialize(offset_annotation_strategy)
  end

  def translate(quartet_of_letters)
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
end
