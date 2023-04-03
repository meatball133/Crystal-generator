class RobotSimulator
  property x : Int32, y : Int32, direction

  def initialize(cordinates : Tuple(Int32, Int32), @direction : Symbol)
    @x = cordinates[0]
    @y = cordinates[1]
  end

  def move(instruction : String)
    instruction.each_char do |char|
      case char
      when 'R'
        turn_right
      when 'L'
        turn_left
      when 'A'
        advance
      end
    end
  end

  def turn_right
    case @direction
    when :north
      @direction = :east
    when :east
      @direction = :south
    when :south
      @direction = :west
    when :west
      @direction = :north
    end
  end

  def turn_left
    case @direction
    when :north
      @direction = :west
    when :west
      @direction = :south
    when :south
      @direction = :east
    when :east
      @direction = :north
    end
  end

  def advance
    case @direction
    when :north
      @y += 1
    when :east
      @x += 1
    when :south
      @y -= 1
    when :west
      @x -= 1
    end
  end
end
