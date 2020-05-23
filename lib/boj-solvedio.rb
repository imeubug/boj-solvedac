require 'net/http'
require 'json'

require './data.rb'

module BOJ
  class BOJSolvedIO < BOJData
    def initialize(update=false)
      super(update)
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
      exit(1) if str == 'exit' or str == 'quit'

      command, level, prob = str.split

      #### print stat for that level(unsolved/solved, etc)
      if command == 'stat'
        if level == "all"
          puts "%-10s %8s %8s %8s" % ["Level", "Unsolved", "Solved", "Total"]
          @stats.each_pair do |k, v|
            stat = @levels[v.to_sym]
            puts "%-10s %8s %8s %8s" % [k, stat[:unsolved], stat[:solved], stat[:total]]
          end
        else
          if !@stats[level.to_sym]
            puts "'#{level}' level does not exist.."
            return
          end
          stat = @levels[@stats[level.to_sym].to_sym]
          puts "%-10s unsolved(%s) solved(%s) total(%s)" % [level, stat[:unsolved], stat[:solved], stat[:total]]
        end
      end

      #### update unsolved/solved 
      # update all
      # update [certian level]
      #
      #
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

    def start
      while true do
        print("> ")
        command(gets.chomp)
      end
    end
  end
end

update = false
boj = BOJ::BOJSolvedIO.new(update)
boj.start
