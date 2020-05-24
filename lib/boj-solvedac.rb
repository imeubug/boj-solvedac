require 'net/http'
require 'json'

require './data.rb'

module BOJ
  class BOJSolvedAC < BOJData
    def initialize(update=false)
      super(update)
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
        puts "'#{command}' not found... try 'help'"
      end

      ##### open a problem from a certain level
      # open random  ---> random problem
      # open [certain level] <prob. number>
      # open [certain level] <random>
      #
      ##### update your solved problem data
      # solved <number>    -----> this appends that number to your data; you should update it by yourself
      # 
      #### remove a problem that you mistakenly put
      # remove <number>
    end

    def command_stat(level)
      if level == "all"
        system('clear')
        puts "%-10s %8s %8s %8s" % ["Level", "Unsolved", "Solved", "Total"]
        @stats.each_pair do |k, v|
          stat = @levels[v.to_sym]
          puts "%-10s %8s %8s %8s" % [k, stat[:unsolved], stat[:solved], stat[:total]]
        end
      elsif %w(bronze silver gold platinum diamond ruby).include? level
        5.downto(1) do |i|
          stat = @levels[@stats[(level+(i.to_s)).to_sym].to_sym]
          puts "%-10s unsolved(%s) solved(%s) total(%s)" % [level+(i.to_s), stat[:unsolved], stat[:solved], stat[:total]]
        end
      else
        if !level or !@stats[level.to_sym]
          puts "'#{level}' level does not exist.."
          return
        end
        stat = @levels[@stats[level.to_sym].to_sym]
        puts "%-10s unsolved(%s) solved(%s) total(%s)" % [level, stat[:unsolved], stat[:solved], stat[:total]]
      end
    end

    def command_prob(level)
      if !level or level.empty? or !@stats[level.to_sym]
        puts "'#{level}' level does not exist.."
        return
      end
      system('clear')
      puts "%-10s %-15s" % ["ID", "Title"]
      list = @levels[@stats[level.to_sym].to_sym][:prob]
      size = list.size
      i = 0
      list.each_pair do |k, v|
        puts "%-10s %-15s" % [k, v]
        i += 1
        if (i+1)%15 == 0
          print("..... (#{i}/#{size}) [q=quit] ") 
          q = gets.chomp
          break if q=='q'
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
      title = problems[id]

      puts
      puts "Level: #{level_str}"
      puts "ID   : #{id} (https://www.acmicpc.net/problem/#{id})"
      puts "Title: #{title}"
      puts
    end

    def command_help
      # prob, stat, random, clear, help
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
        stat:
             stat [LEVEL | all] --> display unsolved/solved/total stats
        random:
             random         --> randomly pick a problem from all levels
             random [LEVEL] --> randomly pick a problem from [LEVEL]
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

update = false
boj = BOJ::BOJSolvedAC.new(update)
boj.start
