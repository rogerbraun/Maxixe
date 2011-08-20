require "spec_helper"

describe Maxixe::Trainer do
  
  it "should generate n-gram data from a set of files" do

    pwd = File.dirname(__FILE__)

    Maxixe::Trainer.generate_training_data([2,3], File.join(pwd, "first_file"), File.join(pwd,"second_file")).should == {2=>{"AB"=>2, "BC"=>2, "CD"=>1, "DE"=>1, "EF"=>1, "FG"=>1, "G\n"=>1, "CX"=>1, "XY"=>1, "YZ"=>1, "Z\n"=>1}, 3=>{"ABC"=>2, "BCD"=>1, "CDE"=>1, "DEF"=>1, "EFG"=>1, "FG\n"=>1, "BCX"=>1, "CXY"=>1, "XYZ"=>1, "YZ\n"=>1}}

  end

end
