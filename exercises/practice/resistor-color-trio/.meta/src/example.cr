module ResistorColorTrio
  enum Color
    Black
    Brown
    Red
    Orange
    Yellow
    Green
    Blue
    Violet
    Grey
    White
  end

  def self.label(values : Array(String)) : String
    value = (Color.parse(values[0]).value.to_i128 * 10 + Color.parse(values[1]).value.to_i128) * 10**Color.parse(values[2]).value.to_i128
    case value
    when 1000..999_999
      "#{(value / 1000).to_i} kiloohms"
    when 1_000_000..999_999_999
      "#{(value / 1_000_000).to_i} megaohms"
    when 1_000_000_000..999_999_999_999
      "#{(value / 1_000_000_000).to_i} gigaohms"
    else
      "#{value} ohms"
    end
  end
end
