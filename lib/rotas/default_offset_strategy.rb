class RotasDefaultOffsetStrategy
  def call(x)
    return sprintf "[%s]", x
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
