require 'markov_chain'

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
      @markov_chain.increment_probability( *( sentence.split ) )
    }
  end
end
