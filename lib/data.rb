require './parser.rb'

class BOJData < Parser
  attr_accessor :levels

  def initialize(update=false)
    update_data if update
    @@levels = {}
    fetch_data
  end

  # update unsolved/solved data
  # update certain level only
  def update_data(level=nil)
    #    parse_levels(level)
    #    parse_problems(level)
  end

  # read unsolved/solved from a file
  def fetch_data
    fetch_level_data
    fetch_problems_data
  end

  def fetch_level_data
    stats = IO.readlines("stats/levels/level-stat.dat")
    stats.each do |stat|
      stat = stat.split(',')
      level    = stat[0]
      unsolved = stat[1]
      solved   = stat[2]
      total    = stat[3].chomp

      @@levels[level.to_sym] = {unsolved: unsolved, solved: solved, total: total, prob: {}}
    end
  end

  def fetch_problems_data
  end
end
