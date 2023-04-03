module Wordy
  def self.answer(question : String) : Number
    question = question.gsub(/What is | by|\?/, "").split(" ")
    result = question[0].to_i
    question.each_with_index do |word, index|
      if /\d+/.match(word)
        if question[index + 1]?
          if /\d+/.match(question[index + 1])
            raise ArgumentError.new("Invalid question")
          end
        end
        next
      elsif question[index + 1]?
        unless question[index + 1].to_i.to_s
          raise ArgumentError.new("Invalid question")
        end
      else
        raise ArgumentError.new("Invalid question")
      end
      case word
      when "plus"
        result += question[index + 1].to_i
      when "minus"
        result -= question[index + 1].to_i
      when "multiplied"
        result *= question[index + 1].to_i
      when "divided"
        result /= question[index + 1].to_i
      else
        raise ArgumentError.new("Invalid question")
      end
    end
    result
  end
end
