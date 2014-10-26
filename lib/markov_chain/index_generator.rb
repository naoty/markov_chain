require "okura/serializer"

module MarkovChain
  class IndexGenerator
    EOS_PATTERN = /。/

    def initialize(dictionary_path)
      @index = Index.new
      @tagger = Okura::Serializer::FormatInfo.create_tagger(dictionary_path)
    end

    def generate(text)
      trimmed_text = Index::BOS + text.gsub(/#{$/}/) { "" } + Index::EOS
      nodes = @tagger.parse(trimmed_text)
      nodes.mincost_path.each_cons(2) do |nodes|
        token, chained_token = nodes.map { |node| node.word.surface }

        if token =~ EOS_PATTERN
          @index.add(token: token, chained_token: Index::EOS)
          @index.add(token: Index::BOS, chained_token: chained_token)
        else
          @index.add(token: token, chained_token: chained_token)
        end
      end
      @index
    end
  end
end