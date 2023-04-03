module ArmstrongNumbers
  extend self

  def armstrong_number?(input : Number) : Bool
    number = "#{input}"
    length = number.size

    input == number.chars.reduce(0_i128) { |acc, i| acc + i.to_i.to_i128 ** length }
  end
end
