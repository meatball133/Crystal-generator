MATH_METHODS   = {"+" => :+, "-" => :-, "*" => :*, "/" => :/}
STACK_METHODS  = {"drop", "swap", "dup", "over"}
REQUIRE_AMOUNT = {"+" => 2, "-" => 2, "*" => 2, "/" => 2, "swap" => 2, "over" => 2, "dup" => 1, "drop" => 1}

class Forth
  def self.stack_operation(operation, min, result)
    if result.size < min
      raise ArgumentError.new
    end
    case operation
    when "dup"
      result << result[-1]
    when "drop"
      result.pop
    when "swap"
      result[-2], result[-1] = result[-1], result[-2]
    when "over"
      result << result[-2]
    end
    result
  end

  def self.math_operation(operation, result)
    if result.size < 2 || (operation == :/ && result[-1] == 0)
      raise ArgumentError.new
    end
    a = result.pop
    b = result.pop
    case operation
    when :+
      result << (b + a)
    when :-
      result << (b - a)
    when :/
      result << (b / a).to_i
    when :*
      result << (b * a)
    end
    result
  end

  def self.evaluate(inputs, result = [] of Int32, methods = {} of String => String)
    status = false
    method = [] of String
    inputs = inputs.downcase
    inputs = inputs.gsub(";", "; ")
    inputs_array = inputs.split(" ")
    inputs_array.each do |x|
      if x == ";"
        methods[method[0]] = method[1..-1].map { |x| methods.keys.includes?(x) ? self.evaluate(x, [] of Int32, methods).join(" ") : x }.join(" ")
        status = false
        method = [] of String
      elsif status
        method << x
      elsif methods.keys.includes?(x)
        result = self.evaluate(methods[x], result, methods)
      elsif x.match(/[0-9]/)
        result << x.to_i
      elsif MATH_METHODS.keys.includes?(x)
        result = self.math_operation(MATH_METHODS[x], result)
      elsif STACK_METHODS.includes?(x)
        result = self.stack_operation(x, REQUIRE_AMOUNT[x], result)
      elsif x == ":"
        status = true
      else
        raise ArgumentError.new
      end
    end
    result
  end
end
