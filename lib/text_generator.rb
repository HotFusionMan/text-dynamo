require 'lib/markov_chain'

class TextGenerator
  attr_reader :markov_chain

  def initialize
    @markov_chain = MarkovChain.new
  end

  def sentences( text )
    text.scan( /[^\.!]+[\.!]/ ).each { |s| s.lstrip! }
  end

  def seed( text )
    sentences( text ).each { |sentence|
      words = sentence.split

      0.upto( words.size - 2 ) { |i|
        @markov_chain.increment_probability( words[i], words[i + 1] )
      }
    }
  end

  def generate( start )
    "Start at the beginning."
  end
end
