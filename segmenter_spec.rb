require "./algorithm.rb"

describe Segmenter do
  describe "internal functions" do

    before(:each) do 
      @sentence = "1234567"
      @two_grams = @sentence.each_char.each_cons(2).to_a
      @three_grams = @sentence.each_char.each_cons(3).to_a
      @segmenter = Segmenter.new({"2" => "", "3" => ""}, nil)
    end

    it "should give all non_straddling n_grams for a given position" do

      # only right segment exists
      @segmenter.non_straddling(@two_grams, 0).should == ["23"] 
      @segmenter.non_straddling(@three_grams, 0).should == ["234"] 

      # only left segment exists
      @segmenter.non_straddling(@two_grams, 5).should == ["56"]
      @segmenter.non_straddling(@three_grams, 5).should == ["456"]

      # both segments exists
      @segmenter.non_straddling(@two_grams, 1).should == ["12","34"]
      @segmenter.non_straddling(@three_grams, 2).should == ["123", "456"]

    end

    it "should give all straddling n_grams for a given position" do

      @segmenter.straddling(@two_grams, 1).should == ["23"]
      @segmenter.straddling(@three_grams, 1).should == ["123", "234"]
      @segmenter.straddling(@three_grams, 0).should == ["123"]

    end

    it "should give all straddling and non straddling n-grams for a given string and all positions" do
      
      res = @segmenter.straddling_and_non_straddling(@two_grams, @sentence)

      res.size.should == @sentence.size - 1
      
      res[0].should == [["23"],["12"]]
      res[1].should == [["12","34"],["23"]]

      res = @segmenter.straddling_and_non_straddling(@three_grams, @sentence)
      res[0].should == [["234"],["123"]]
      res[1].should == [["345"],["123","234"]]

    end

    it "should average votes" do
      votes = [[1,0,1,0],[0,1,0,1]]
      @segmenter.average_votes(votes).should == [0.5, 0.5, 0.5, 0.5]
    end
  end
end
