module MarkovChain
  class RandomText
    def initialize(index)
      @index = index
    end

    def to_s
      text = []

      token = Index::BOS
      while token = @index[token]
        break if token == Index::EOS
        text << token
      end

      text.join
    end
  end
end