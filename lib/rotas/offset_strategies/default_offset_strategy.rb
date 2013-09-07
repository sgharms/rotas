class RotasDefaultOffsetStrategy
  PREFIX_CONTENT = [ '', '', 'with ', 'in/on ' ]

  def call(x)
    return sprintf "[%s] ", x
  end

  def format_line(tokens)
    line = ""
    token_index = 0

    while !tokens.empty? do
      if tokens.first !~ /[A-Za-z]/
        line += tokens.shift
      else
        line += PREFIX_CONTENT[token_index]

        token = tokens.shift
        if token_index >= 2
          line += "#{a_or_an(token)} "
        else
          line += "#{token}"
        end
        token_index += 1
      end
    end

    line = line.gsub(/(\s)+/, '\1').gsub(/\s+\Z/, '')
    line += '.'
  end

  def a_or_an(word)
    word = word.to_s
    %w/a e i o u/.include?(word[0].downcase) ? "an #{word}" : "a #{word}"
    rescue
      STDERR.puts "Failed to process [#{word}]"
      raise
  end
end
