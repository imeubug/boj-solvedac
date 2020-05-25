require './parser.rb'

class BOJData < Parser
  def initialize(update=false)
    update_data if update
    @@levels = {}
    fetch_data
  end

=begin
  #
  # only used by [jione eu] to fetch the data from the web
  #
  def update_data(level=nil)
    parse_levels(level)
    parse_problems(level)
  end
=end

  # read unsolved/solved from a file
  def fetch_data
    fetch_level_data
    fetch_problems_data
    fetch_solved_data
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
    level_min = 0
    level_max = 30
    for i in level_min..level_max do
      path = "stats/problems/level#{i}.dat"
      arr = IO.readlines(path)
      # problem id, title
      arr.each do |prob|
        id, title = prob.chomp.split(',')
        solved = false
        @@levels[i.to_s.to_sym][:prob][id.to_sym] = {title: title, solved: solved}
      end
    end
  end

  def fetch_solved_data
    path = "stats/solved-problems.dat"
    solved = IO.read(path).to_s.chomp.split(' ')
    solved_size = solved.size
    level_min = 0
    level_max = 30

    for i in level_min..level_max do
      solved_prob = 0
      level = @@levels[i.to_s.to_sym][:prob] # id = {title, solved}
      solved.each do |solved_id|
        if level[solved_id.to_sym] != nil
          level[solved_id.to_sym][:solved] = true
          solved_prob += 1
        end
      end
      @@levels[i.to_s.to_sym][:solved] = solved_prob
      @@levels[i.to_s.to_sym][:unsolved] = ((@@levels[i.to_s.to_sym][:unsolved].to_i) - solved_prob).to_s

      break if solved_prob == solved_size
    end
  end
end
