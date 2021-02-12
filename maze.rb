# @thanks
# http://weblog.jamisbuck.org/2010/12/27/maze-generation-recursive-backtracking
# https://gist.githubusercontent.com/jamis/755866/raw/85fe436bdcbba2da588ed366b322e02fedba42bb/recursive-backtracker2.rb
#
# --------------------------------------------------------------------
# An implementation of the "Growing Tree" algorithm. This one is
# notable for it's ability to become nearly identical to Prim's
# algorithm, or the Recursive Backtracking algorithm, depending on
# how the cells are removed from the list that aggregates as the
# algorithm runs.
#
# This script allows you to play with those settings by specifying
# the mode after the width and height parameters, as "random" (pull
# the cell from list at random), "newest" (pull the newest cell),
# "middle" (pull the cell from the middle of the list), "oldest"
# (pull the oldest cell), or a combination of any of these, e.g.:
#
#   ruby growing-tree.rb 10 10 newest:50,random:50
#
# That would select the newest cell half of the time, and a random
# cell the other half of the time. You can specify a sequence of
# commands as well, to be chosen in order, by separating them with
# semicolons; each subcommand may then be a comma-delimited list of
# options to select randomly:
#
#   ruby growing-tree.rb 10 10 "newest;newest;oldest,middle"
#
# Always choosing the newest cell will mimic recursive backtracking,
# and always choosing a random cell will mimic Prim's. Experiment and
# see what you get!
# --------------------------------------------------------------------

# --------------------------------------------------------------------
# 1. Allow the maze to be customized via command-line parameters
# --------------------------------------------------------------------

width  = (ARGV[0] || 10).to_i
height = (ARGV[1] || width).to_i
mode   = (ARGV[2] || "random")
seed   = (ARGV[3] || rand(0xFFFF_FFFF)).to_i

srand(seed)

grid = Array.new(height) { Array.new(width, 0) }

# --------------------------------------------------------------------
# 2. Set up constants to aid with describing the passage directions
# --------------------------------------------------------------------

N, S, E, W = 1, 2, 4, 8
DX         = { E => 1, W => -1, N =>  0, S => 0 }
DY         = { E => 0, W =>  0, N => -1, S => 1 }
OPPOSITE   = { E => W, W =>  E, N =>  S, S => N }

# --------------------------------------------------------------------
# 3. Data structures to assist the algorithm
# --------------------------------------------------------------------

class Script
  def initialize(arg)
    @commands = arg.split(/;/).map { |cmd| parse_command(cmd) }
    @current = 0
  end

  def parse_command(cmd)
    total_weight = 0
    parts = cmd.split(/,/).map do |element|
      name, weight = element.split(/:/)
      weight ||= 100
      abort "commands must be random, newest, middle, or oldest (was #{name.inspect})" unless %w(random r newest n middle m oldest o).include?(name)
      total_weight += weight.to_i
      { :name => name.to_sym, :weight => total_weight }
    end
    { :total => total_weight, :parts => parts }
  end

  def next_index(ceil)
    command = @commands[@current]
    @current = (@current + 1) % @commands.length

    v = rand(command[:total])
    command[:parts].each do |part|
      if v < part[:weight]
        case part[:name]
        when :random, :r then return rand(ceil)
        when :newest, :n then return ceil-1
        when :middle, :m then return ceil/2
        when :oldest, :o then return 0
        end
      end
    end

    abort "[bug] failed to find index (#{v} of #{command.inspect})"
  end

  def to_s
    @commands.map do |command|
      v = 0
      command[:parts].map { |part| s = "#{part[:name]}:#{part[:weight]-v}"; v = part[:weight]; s }.join(",")
    end.join(";")
  end
end

cells = []
script = Script.new(mode)

# --------------------------------------------------------------------
# 4. A simple routine to emit the maze as ASCII
# --------------------------------------------------------------------
def display_maze(grid)
  puts "#  " + "_" * (grid[0].length * 2 - 1)
  grid.each_with_index do |row, y|
    print "# |"
    row.each_with_index do |cell, x|
      if cell == 0 && y+1 < grid.length && grid[y+1][x] == 0
        print " "
      else
        print((cell & S != 0) ? " " : "_")
      end

      if cell == 0 && x+1 < row.length && row[x+1] == 0
        print((y+1 < grid.length && (grid[y+1][x] == 0 || grid[y+1][x+1] == 0)) ? " " : "_")
      elsif cell & E != 0
        print(((cell | row[x+1]) & S != 0) ? " " : "_")
      else
        print "|"
      end
    end
    puts
  end
end

def print_blocks(grid, io=STDOUT, h=1, w=2)

  border_block = ENV['border_block'] || 'red_concrete'
  floor_block = ENV['floor_block'] || 'white_concrete'
  vwall = ENV['vwall'] || 'black_stained_glass'
  hwall = ENV['hwall'] || 'red_concrete'
  wall_height = (ENV['wall_height'] || 2).to_i


  # print "\e[H" # move to upper-left
  # puts " " + "_" * 
  max_y = (grid[0].length * w) - 1
  half = (w / 2.0).ceil().to_i
  io.puts("# erase everything ")
  io.puts("fill ^#{-w} ^-1 ^#{-w} ^#{max_y+w+2} ^#{h+3} ^#{max_y+w+2} air")
  io.puts("# floor")
  io.puts("fill ^-1 ^-1 ^ ^#{max_y} ^-1 ^#{max_y} #{floor_block}")
  grid.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      bottom_bar = "fill ^#{x*w-1} ^ ^#{y*w+half} ^#{x*w+half} ^#{wall_height-1} ^#{y*w+half} #{hwall}\n"
      bottom_bar << "fill ^#{x*w-1} ^-1 ^#{y*w+half} ^#{x*w+half} ^-1 ^#{y*w+half} sea_lantern\n"

      if cell == 0 && y+1 < grid.length && grid[y+1][x] == 0
        # print " "
        # io.puts("fill ^#{x*w} ^#{h + 2} ^#{y*w} ^#{x*w} ^#{h + 2} ^#{y*w} sea_lantern")
      else
        io.print((cell & S != 0) ? "" : bottom_bar)
      end

      if cell == 0 && x+1 < row.length && row[x+1] == 0
        io.print((y+1 < grid.length && (grid[y+1][x] == 0 || grid[y+1][x+1] == 0)) ? "" : bottom_bar)
      elsif cell & E != 0
        io.print(((cell | row[x+1]) & S != 0) ? "" : bottom_bar)
      else
        # print "|"
        io.puts("fill ^#{x*w+half} ^ ^#{y*w} ^#{x*w+half} ^#{wall_height-1} ^#{y*w+half} #{vwall}")
        io.puts("fill ^#{x*w+half} ^-1 ^#{y*w} ^#{x*w+half} ^-1 ^#{y*w+half} sea_lantern")
      end
    end
    io.puts
  end
  io.puts("# borders")
  io.puts("fill ^ ^ ^ ^#{max_y} ^#{h+3} ^ #{border_block}")
  io.puts("fill ^ ^ ^#{max_y} ^#{max_y} ^#{h+3} ^#{max_y} #{border_block}")
  io.puts("fill ^-1 ^ ^#{max_y} ^-1 ^#{h+3} ^ #{border_block}")
  io.puts("fill ^#{max_y} ^ ^ ^#{max_y} ^#{h+3} ^#{max_y} #{border_block}")
end

# --------------------------------------------------------------------
# 5. Growing Tree algorithm
# --------------------------------------------------------------------

x, y = rand(width), rand(height)
cells << [x, y]

until cells.empty?
  index = script.next_index(cells.length)
  x, y = cells[index]

  [N, S, E, W].shuffle.each do |dir|
    nx, ny = x + DX[dir], y + DY[dir]
    if nx >= 0 && ny >= 0 && nx < width && ny < height && grid[ny][nx] == 0
      grid[y][x] |= dir
      grid[ny][nx] |= OPPOSITE[dir]
      cells << [nx, ny]
      index = nil
      break
    end
  end

  cells.delete_at(index) if index
end

puts("# seed #{seed} ")
display_maze(grid)
print_blocks(grid, io=STDOUT, h=1, w=3)
# print(grid)

# --------------------------------------------------------------------
# 5. Show the parameters used to build this maze, for repeatability
# --------------------------------------------------------------------

# puts "#{$0} #{width} #{height} #{script} #{seed}"
