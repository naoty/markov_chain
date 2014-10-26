module MarkovChain
  class Index
    BOS = "BOS"
    EOS = "EOS"

    def initialize
      @tokens_table = {}
    end

    def [](token)
      @tokens_table[token].sample
    end

    def add(token: "", chained_token: "")
      @tokens_table[token] ||= []
      @tokens_table[token] << chained_token
    end
  end
end