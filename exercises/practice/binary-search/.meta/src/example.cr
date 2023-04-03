class BinarySearch
  getter list : Array(Int32)

  def initialize(@list : Array(Int32))
  end

  def find(datum)
    raise ArgumentError.new "value not in array" if list.empty?
    return middle if list[middle] == datum

    if list[middle.to_i] > datum
      sublist = list[0...middle]
      raise ArgumentError.new "value not in array" if sublist == list
      return BinarySearch.new(sublist).find(datum)
    else
      sublist = list[middle..-1]
      raise ArgumentError.new "value not in array" if sublist == list
      result = BinarySearch.new(sublist).find(datum)
      return result + middle
    end
  end

  private def middle
    (list.size / 2).to_i
  end
end
