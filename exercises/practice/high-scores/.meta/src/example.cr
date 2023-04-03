class HighScores
  property scores : Array(Int32)

  def initialize(@scores : Array(Int32))
  end

  def latest : Int32
    @scores.last
  end

  def personal_best : Int32
    @scores.max
  end

  def personal_top_three : Array(Int32)
    @scores.sort.reverse[0, 3]
  end
end
