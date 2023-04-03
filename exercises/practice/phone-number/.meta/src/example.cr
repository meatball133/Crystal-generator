module PhoneNumber
  def self.clean(phrase : String) : String
    phrase = phrase.gsub(/[. ()+-]/, "")
    phrase = phrase[0].to_i == 1 ? phrase[1..] : phrase
    if phrase.size != 10 || !phrase.chars.all? { |x| ('0'..'9').includes?(x) } || !(2..9).includes?(phrase[0].to_i) || !(2..9).includes?(phrase[3].to_i)
      raise ArgumentError.new("error")
    end
    phrase
  end
end
