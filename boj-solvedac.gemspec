Gem::Specification.new do |s|
  s.name          = "boj-solvedac"
  s.version       = "0.4.2"
  s.date          = "2020-05-29"
  s.summary       = "Baekjoon Online Judge - Solved.ac Command Line Interface tool"
  s.author        = ["Jione Eu"]
  s.files         = ['lib/boj-solvedac.rb', 'lib/data/data.rb', 'lib/colorize/colorize.rb']
  s.homepage      = "https://solved.ac/"
  s.license       = "MIT"
  s.metadata = {
    "documentation_uri" => "https://github.com/jioneeu/boj-solvedac"
  }
  s.description = <<-EOF
  version 0.4.0 -> colors added to each level
  version 0.4.1 -> 'solved' command overwriting 'solved-problems.dat' bug fixed.
  version 0.4.2 -> 'ruby' and 'unrated' color swapped.
  EOF
end
