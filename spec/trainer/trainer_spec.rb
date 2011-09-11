require "spec_helper"

describe Maxixe::Trainer do
  
  it "should generate n-gram data from IOs" do

    pwd = File.dirname(__FILE__)

    Maxixe::Trainer.generate_corpus_from_io([2,3], open(File.join(pwd, "first_file"))).should == {"2"=>{"AB"=>1, "BC"=>1, "CD"=>1, "DE"=>1, "EF"=>1, "FG"=>1, "G\n"=>1}, "3"=>{"ABC"=>1, "BCD"=>1, "CDE"=>1, "DEF"=>1, "EFG"=>1, "FG\n"=>1}}

  end

  it "should be able to find the optimal threshold and n values" do
    pre_segmented = [["MYDOGISINTHEHOUSE", "MY DOG IS IN THE HOUSE"],
                     ["FOURNICEDOGS", "FOUR NICE DOGS"],
                     ["MYCATLIKESMYDOG", "MY CAT LIKES MY DOG"]]
    index = Maxixe::Trainer.generate_corpus_from_io([2,3,4,5], "ILIKEMYDOG
THISHOUSEISMYHOUSE
MYDOGISSONICE
WHOLIKESDOGSANYWAY
CATSANDDOGSUSUALLYFIGHT
INMYHOUSETHEREAREFOURDOGS
IWANTAHOUSEFORMYDOG")
  
    optimal = Maxixe::Trainer.optimize(index, pre_segmented)
    optimal[:n].should == ["2","4"]
    optimal[:score].should == 0
    optimal[:t].should be_within(0.01).of(0.5)

  end


end
