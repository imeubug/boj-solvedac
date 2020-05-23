class Parser
  # level = nil   -> update all levels
  def parse_levels(level)
    puts " parsing level stats..."
    url = "https://solved.ac/problems/level"
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    html = response.body
    html = html.scan(/level\/#{level ? level : '\d+'}\/*.*>\d+,*\d*/)
    html.map! {|line| (line.split(/\"\s?>/))[1]}

    size = html.size/3
    File.open("stats/levels/level-stat.dat", "w+") do |file|
      str = ""
      for i in 0...size
        level    = i
        unsolved = html[3*i].tr(',','')
        solved   = html[3*i+1].tr(',','')
        total    = html[3*i+2].tr(',','')

        str = "#{level},#{unsolved},#{solved},#{total}"
        file.puts str
      end
    end
  end

  def parse_problems(level)
    for i in 1..1 do
      puts "...page #{i} parsing..."
      url = "https://solved.ac/problems/level/30?page=#{i}"
      uri = URI(url)
      response = Net::HTTP.get_response(uri)
      html = response.body
      html = html.scan(/<a href="\/\/acmicpc.*\s*.*/)
      html.map! {|line| (((line.split('<')[1]).split("problem\/")[1]).split(/\".*/))}
      html.each do |line|
        line[1] = line[1].tr("\n ",'')
      end

      # Solved  PROBLEM   TITLE
      # [x]      1000      A+B
      File.open("stats/problems/level30.dat", "a+") do |file|
        html.each do |problem|
          id = problem[0]
          title = problem[1]
          file.puts "#{id},#{title}"
        end
      end
    end
  end
end
