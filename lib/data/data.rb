class BOJData
  def initialize()
    @@levels = {}
    fetch_data
  end

  def fetch_data
    fetch_level_data
    fetch_problems_data
    fetch_solved_data
  end

  def fetch_level_data
    puts "Feteching level stats..."
    if !File::exists?("stats/level-stat.dat")
      system("clear")
      puts "'stats/level-stat.dat' does not exist... fetching"
      system("mkdir stats 2> /dev/null")
      system("curl -o stats/level-stat.dat https://raw.githubusercontent.com/jioneeu/boj-solvedac/master/lib/data/stats/level-stat.dat")
    end
    stats = IO.readlines("stats/level-stat.dat")
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
    puts "fetching problems...."
    system("mkdir stats/problems 2> /dev/null")
    level_min = 0
    level_max = 30
    for i in level_min..level_max do
      path = "stats/problems/level#{i}.dat"
      if !File::exists?(path)
        system("clear")
        puts "'stats/problems/level#{i}.dat' does not exist... fetching"
        system("curl -o stats/problems/level#{i}.dat https://raw.githubusercontent.com/jioneeu/boj-solvedac/master/lib/data/stats/problems/level#{i}.dat")
      end
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
    if !File::exists?(path)
      puts "No solved data exists... skipping"
      return
    end
    File.open("stats/solved-problems.dat", "r+")
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
