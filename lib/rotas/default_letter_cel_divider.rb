class RotasDefaultLetterCelDivider
  def initialize(group_by)
    @group_by = group_by
  end

  def call(rotatable_line)
    outer_accumulator = []
    inner_accumulator = []
    tokens_counter = 0

    rotatable_line.split('').each do | token |
      if [*'A'..'Z'].include?(token) || [*'a'..'z'].include?(token)
        tokens_counter += 1
      end

      inner_accumulator << token

      if tokens_counter == @group_by
        tokens_counter = 0
        outer_accumulator << inner_accumulator
        inner_accumulator = []
      end
    end

    outer_accumulator << inner_accumulator if !inner_accumulator.empty?
    outer_accumulator
  end
end
