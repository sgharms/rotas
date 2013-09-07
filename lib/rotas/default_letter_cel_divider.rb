class RotasDefaultLetterCelDivider
  def initialize(group_by)
    @group_by = group_by
  end

  def call(word_to_rotate)
     word_to_rotate.split('').each_slice(@group_by)
  end
end
