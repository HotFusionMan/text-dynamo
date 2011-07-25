class TextGenerator
  def sentences( text )
    text.scan( /[^\.!]+[\.!]/ ).each { |s| s.lstrip! }
  end
end
