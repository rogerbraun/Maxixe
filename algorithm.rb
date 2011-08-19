class Segmenter
  
  attr_accessor :t
  
  def initialize(index, t)
    @index = index
    @n = index.keys.map(&:to_i)
    @t = t
  end

  def segment(str, t = nil)

    n_grams = all_n_grams(str)
    
    votes_for_all = n_grams.map{|n| compute_votes(straddling_and_non_straddling(n,str), n.first.size)}

    averaged = average_votes(votes_for_all)

    split_with_votes(averaged, str, t)

  end

  def split_with_votes(votes, str, t = nil)
    points = []
    votes.each_with_index do |vote, i|
      treshold = vote > (t || @t)
      maximum = if i > 0 and i < (votes.size - 1)
        vote > votes[i - 1] and vote > votes[i + 1]
      else false end 

      points << i if treshold or maximum
    end 

    res = str.dup
    offset = 1
    points.each do |p|
      res.insert(p + offset, " ")
      offset += 1
    end

    res 

  end

  def all_n_grams str
    @n.map do |n| str.each_char.each_cons(n).to_a end
  end

  def token_count(n_gram)
    @index[n_gram.length.to_s][n_gram] || 0
  end

  def straddling_and_non_straddling n_grams, str
    (0..(str.length - 2)).map do |pos|
      [non_straddling(n_grams, pos), straddling(n_grams, pos)]
    end
  end

  def non_straddling n_grams, pos
    res = []
    n_grams.each_with_index do |n_gram, i|
      res << n_gram if i == pos + 1 or i == pos - (n_gram.size - 1)
    end
    res.map(&:join)
  end

  def straddling n_grams, pos
    res = []
    n_grams.each_with_index do |n_gram, i|
      res << n_gram if i <= pos and i > pos - (n_gram.size - 1)
    end
    res.map(&:join)
  end

  def compute_votes positions_with_ngrams, n
    positions_with_ngrams.map do |(non_strad, strad)|
      compute_vote(non_strad, strad, n)
    end
  end

  def compute_vote(non_strad, strad, n)
    res = non_strad.inject(0) do |res, s|
      res + strad.inject(0) do |res_2, t|
        res_2 + ((token_count(s) > token_count(t)) ? 1 : 0)
      end
    end 
    res / (2.0 * (n - 1))
  end

  def average_votes(votes)
    votes.transpose.map do |vote_array|
      vote_array.inject(&:+).to_f / vote_array.size
    end
  end
end
