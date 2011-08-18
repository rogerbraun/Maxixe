class Segmenter
  
  def initialize(index)
    @index = index
    @n = index.size
  end

  def token_count(tokens)

    tokens.inject(0){|r, v| r += @index[token.length][token]}

  end


  def segment(str)
    votes = @n.map do |n|
      
      n_grams = str.each_char.each_cons(n).to_a

      puts n_grams.inspect
      
      1.upto(str.length - 1).map do |pos|
        non_straddling = []
       
        non_straddling << (n_grams[pos - n]) if (pos - n ) >= 0
        non_straddling << n_grams[pos] if pos <= (str.length - n)

        from = [pos - (n - 1), 0].max
        to = [str.length - n, pos - 1].min

        straddling = (from..to).map{|p_2| n_grams[p_2]}

        token_count(non_straddling) > token_count(straddling) ? 1 : 0

      end

    end

  end

end
