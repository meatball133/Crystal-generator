module RotationalCipher
  def self.rotate(plaintext : String, key : Number) : String
    result = ""
    plaintext.each_char do |char|
      if ('a'..'z').includes?(char)
        result += ((char.ord - 'a'.ord + key) % 26 + 'a'.ord).chr
      elsif ('A'..'Z').includes?(char)
        result += ((char.ord - 'A'.ord + key) % 26 + 'A'.ord).chr
      else
        result += char
      end
    end
    result
  end
end
