require "spec"
require "../src/*"

describe "ResistorColorDuo" do
  it "Brown and black" do
    ResistorColorDuo.value(["brown", "black"]).should eq(10)
  end

  pending "Blue and grey" do
    ResistorColorDuo.value(["blue", "grey"]).should eq(68)
  end

  pending "Yellow and violet" do
    ResistorColorDuo.value(["yellow", "violet"]).should eq(47)
  end

  pending "White and red" do
    ResistorColorDuo.value(["white", "red"]).should eq(92)
  end

  pending "Orange and orange" do
    ResistorColorDuo.value(["orange", "orange"]).should eq(33)
  end

  pending "Ignore additional colors" do
    ResistorColorDuo.value(["green", "brown", "orange"]).should eq(51)
  end

  pending "Black and brown, one-digit" do
    ResistorColorDuo.value(["black", "brown"]).should eq(1)
  end
end
