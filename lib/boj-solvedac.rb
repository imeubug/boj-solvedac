require 'data/data.rb'

module BOJ
  class BOJSolvedAC < BOJData
    def initialize()
      super()
      @prev = ''
      @levels = @@levels
      @stats = {
        "unrated": "0",
        "bronze5": "1", "bronze4": "2", "bronze3": "3", "bronze2": "4", "bronze1": "5",
        "silver5": "6", "silver4": "7", "silver3": "8", "silver2": "9", "silver1": "10",
        "gold5": "11", "gold4": "12", "gold3":   "13", "gold2": "14", "gold1":   "15",
        "platinum5": "16", "platinum4": "17", "platinum3": "18", "platinum2": "19", "platinum1": "20",
        "diamond5": "21", "diamond4": "22", "diamond3": "23", "diamond2": "24", "diamond1": "25",
        "ruby5": "26", "ruby4": "27", "ruby3": "28", "ruby2": "29", "ruby1": "30"
      }
      system('clear')
    end

    def command(str)
      if !str.empty? and @prev != str
        @prev = str
      end
      command, level = @prev ? @prev.split : str.split
      command.downcase! if command
      level.downcase! if level

      case command
      when 'stat' then command_stat(level)
      when 'prob' then command_prob(level)
      when 'random' then command_random(level)
      when 'clear' then system('clear')
      when 'help' then command_help
      when /exit|quit/ then exit(1)
      else 
        if command
          puts "'#{command}' not found... try 'help'"
        end
      end
    end

    def command_stat(level)
      @prev = ''
      if level == "all"
        puts "%-10s %8s %8s %8s" % ["Level", "Unsolved", "Solved", "Total"]
        @stats.each_pair do |k, v|
          stat = @levels[v.to_sym]
          puts "%-10s %8s %8s %8s" % [k, stat[:unsolved], stat[:solved], stat[:total]]
        end
      elsif %w(bronze silver gold platinum diamond ruby).include? level
        5.downto(1) do |i|
          stat = @levels[@stats[(level+(i.to_s)).to_sym].to_sym]
          puts "%-10s unsolved(%3s) solved(%3s) total(%3s)" % [level+(i.to_s), stat[:unsolved], stat[:solved], stat[:total]]
        end
      else
        if !level or !@stats[level.to_sym]
          puts "'#{level}' level does not exist.."
          return
        end
        stat = @levels[@stats[level.to_sym].to_sym]
        puts "%-10s unsolved(%3s) solved(%3s) total(%3s)" % [level, stat[:unsolved], stat[:solved], stat[:total]]
      end
    end

    def command_prob(op)
      @prev = ''
      if !op or op.empty? or (op!="solved" and !@stats[op.to_sym])
        puts "'#{op}' op does not exist.."
        return
      end

      puts "%-10s %-15s" % ["ID", "Title"]

      if op == "solved"
        level_min = 0
        level_max = 30
        solved = {}

        for i in level_min..level_max do
          probs = @levels[i.to_s.to_sym][:prob] # id = {title, solved}
          probs.each_pair do |k, v|
            if v[:solved]
              solved[k.to_s.to_i] = {level: @stats.keys[i], title: v[:title]}
            end
          end
        end

        solved = solved.sort
        i = 0
        solved.each do |prob|
          puts "%-10s%-10s%-15s" % [prob[1][:level], prob[0], prob[1][:title]]
          i+=1
          if (i+1)%10 == 0
            print("..... [q=quit] ") 
            q = gets.chomp
            break if q=='q'
          end
        end
      else
        list = @levels[@stats[op.to_sym].to_sym][:prob]
        size = list.size
        i = 0
        list.each_pair do |k, v|
          puts "%-10s %-15s" % [k, v[:title]]
          i += 1
          if (i+1)%15 == 0
            print("..... (#{i}/#{size}) [q=quit] ") 
            q = gets.chomp
            break if q=='q'
          end
        end
      end
      puts "----------------------\n"
    end

    def  command_random(level)
      problems = @levels[@stats[level.to_sym].to_sym][:prob] unless level==nil
      level_str = level

      if level == nil
        max_level = 31
        level = rand(max_level).to_s
        problems = @levels[level.to_sym][:prob]
        level_str = @stats.keys[level.to_i]
      end

      id    = problems.keys[rand(problems.size)]
      title = problems[id][:title]

      puts
      puts "Level: #{level_str}"
      puts "ID   : #{id} (https://www.acmicpc.net/problem/#{id})"
      puts "Title: #{title}"
      puts
    end

    def command_help
      puts '''
      levels you can specify:
        unrated
        bronze[5-1] (bronze5, bronze4, ...)
        silver[5-1]
        gold[5-1]
        platinum[5-1]
        diamond[5-1]
        ruby[5-1]

      Commands:
        prob:
             prob [LEVEL] --> display all [LEVEL] problems
             prob solved  --> display all solved problems by ID
        stat:
             stat [LEVEL | all] --> display [LEVEL]\'s or all levels
                                    unsolved/solved/total stats
        random:
             random         --> randomly pick a problem from all levels
             random [LEVEL] --> randomly pick a problem from [LEVEL]
             * hit [ENTER] to repeat the previous \'random\' command
        clear:
             clear --> clears the screen
        exit:
             exit --> terminate the program
        quit:
             alias to \'exit\'
             '''
    end

    def start
      while true do
        print("boj-solvedac>  ")
        command(gets.chomp)
      end
    end
  end
end
