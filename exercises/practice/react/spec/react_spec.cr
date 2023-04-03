require "spec"
require "../src/*"

describe "React" do
  it "input cells have a value" do
    input = React::InputCell.new(10)
    input.value.should eq(10)
  end

  pending "an input cell's value can be set" do
    input = React::InputCell.new(4)
    input.value = 20
    input.value.should eq(20)
  end

  pending "compute cells calculate initial value" do
    input = React::InputCell.new(1)
    output = React::ComputeCell.new(input) { |input1| input1 + 1 }
    output.value.should eq(2)
  end

  pending "compute cells take inputs in the right order" do
    one = React::InputCell.new(1)
    two = React::InputCell.new(2)
    output = React::ComputeCell.new(one, two) { |input1, input2| input1 + input2 * 10 }
    output.value.should eq(21)
  end

  pending "compute cells update value when dependencies are changed" do
    input = React::InputCell.new(1)
    output = React::ComputeCell.new(input) { |input1| input1 + 1 }
    input.value = 3
    output.value.should eq(4)
  end

  pending "compute cells can depend on other compute cells" do
    input = React::InputCell.new(1)
    times_two = React::ComputeCell.new(input) { |input1| input1 * 2 }
    times_thirty = React::ComputeCell.new(input) { |input1| input1 * 30 }
    output = React::ComputeCell.new(times_two, times_thirty) { |input1, input2| input1 + input2 }
    output.value.should eq(32)
    input.value = 3
    output.value.should eq(96)
  end

  pending "compute cells fire callbacks" do
    value1 = [] of Int32

    input = React::InputCell.new(1)
    output = React::ComputeCell.new(input) { |input1| input1 + 1 }
    callback1 = output.add_callback { |value| value1 << value }
    input.value = 3
    value1[-1].should eq 4
  end

  pending "callback cells only fire on change" do
    value1 = [] of Int32

    input = React::InputCell.new(1)
    output = React::ComputeCell.new(input) { |input1| input1 < 3 ? 111 : 222 }
    callback1 = output.add_callback { |value| value1 << value }
    input.value = 2
    value1.should eq [] of Int32
    input.value = 4
    value1[-1].should eq 222
  end

  pending "callbacks do not report already reported values" do
    value1 = [] of Int32

    input = React::InputCell.new(1)
    output = React::ComputeCell.new(input) { |input1| input1 + 1 }
    callback1 = output.add_callback { |value| value1 << value }
    input.value = 2
    value1[-1].should eq 3
    input.value = 3
    value1[-1].should eq 4
  end

  pending "callbacks can fire from multiple cells" do
    value1 = [] of Int32
    value2 = [] of Int32

    input = React::InputCell.new(1)
    plus_one = React::ComputeCell.new(input) { |input1| input1 + 1 }
    minus_one = React::ComputeCell.new(input) { |input1| input1 - 1 }
    callback1 = plus_one.add_callback { |value| value1 << value }
    callback2 = minus_one.add_callback { |value| value2 << value }
    input.value = 10
    value1[-1].should eq 11
    value2[-1].should eq 9
  end

  pending "callbacks can be added and removed" do
    value1 = [] of Int32
    value2 = [] of Int32
    value3 = [] of Int32

    input = React::InputCell.new(11)
    output = React::ComputeCell.new(input) { |input1| input1 + 1 }
    callback1 = output.add_callback { |value| value1 << value }
    callback2 = output.add_callback { |value| value2 << value }
    input.value = 31
    value1[-1].should eq 32
    value2[-1].should eq 32
    output.remove_callback(callback1)
    callback3 = output.add_callback { |value| value3 << value }
    input.value = 41
    value2[-1].should eq 42
    value3[-1].should eq 42
    value1.size.should eq 1
  end

  pending "removing a callback multiple times doesn't interfere with other callbacks" do
    value1 = [] of Int32
    value2 = [] of Int32

    input = React::InputCell.new(1)
    output = React::ComputeCell.new(input) { |input1| input1 + 1 }
    callback1 = output.add_callback { |value| value1 << value }
    callback2 = output.add_callback { |value| value2 << value }
    output.remove_callback(callback1)
    output.remove_callback(callback1)
    output.remove_callback(callback1)
    input.value = 2
    value2[-1].should eq 3
    value1.should eq [] of Int32
  end

  pending "callbacks should only be called once even if multiple dependencies change" do
    value1 = [] of Int32

    input = React::InputCell.new(1)
    plus_one = React::ComputeCell.new(input) { |input1| input1 + 1 }
    minus_one1 = React::ComputeCell.new(input) { |input1| input1 - 1 }
    minus_one2 = React::ComputeCell.new(minus_one1) { |input1| input1 - 1 }
    output = React::ComputeCell.new(plus_one, minus_one2) { |input1, input2| input1 * input2 }
    callback1 = output.add_callback { |value| value1 << value }
    input.value = 4
    value1[-1].should eq 10
  end

  pending "callbacks should not be called if dependencies change but output value doesn't change" do
    value1 = [] of Int32

    input = React::InputCell.new(1)
    plus_one = React::ComputeCell.new(input) { |input1| input1 + 1 }
    minus_one = React::ComputeCell.new(input) { |input1| input1 - 1 }
    always_two = React::ComputeCell.new(plus_one, minus_one) { |input1, input2| input1 - input2 }
    callback1 = always_two.add_callback { |value| value1 << value }
    input.value = 2
    value1.should eq [] of Int32
    input.value = 3
    value1.should eq [] of Int32
    input.value = 4
    value1.should eq [] of Int32
    input.value = 5
    value1.should eq [] of Int32
  end
end
