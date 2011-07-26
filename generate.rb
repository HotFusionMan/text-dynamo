require 'lib/text_generator'

def usage
  puts "usage:  ruby #{__FILE__} <source text file>"
end

unless ARGV.size > 0
  usage
  exit( 1 )
end

input_file = ARGV[0]

@tg = TextGenerator.new

File.open( input_file ) { |file|
  @tg.seed( file.read )
}

puts @tg.generate
