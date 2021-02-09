dist:
	git archive --format zip --output uberop.zip main

watch:
	#git ls-files | entr -cs 'python compile.py && python refresh.py'
	find . -name '*.jinja' -o -name '*.py' -o -name '*.mcfunction' | entr -cs 'python compile.py && python refresh.py'

mazes:
	ruby maze.rb 15 15 random 01 > data/uberop/functions/mazes/01.mcfunction
	ruby maze.rb 15 15 random 02 > data/uberop/functions/mazes/02.mcfunction
	ruby maze.rb 15 15 random 03 > data/uberop/functions/mazes/03.mcfunction
	ruby maze.rb 15 15 random 04 > data/uberop/functions/mazes/04.mcfunction
	ruby maze.rb 15 15 random 05 > data/uberop/functions/mazes/05.mcfunction
	ruby maze.rb 15 15 random 06 > data/uberop/functions/mazes/06.mcfunction
	ruby maze.rb 15 15 random 07 > data/uberop/functions/mazes/07.mcfunction
	ruby maze.rb 15 15 random 08 > data/uberop/functions/mazes/08.mcfunction
	ruby maze.rb 15 15 random 09 > data/uberop/functions/mazes/09.mcfunction
	ruby maze.rb 15 15 random 10 > data/uberop/functions/mazes/10.mcfunction
	ruby maze.rb 25 25 random 101 > data/uberop/functions/mazes/x74-1.mcfunction
	ruby maze.rb 25 25 random 102 > data/uberop/functions/mazes/x74-2.mcfunction
	ruby maze.rb 25 25 random 103 > data/uberop/functions/mazes/x74-3.mcfunction
	ruby maze.rb 25 25 random 104 > data/uberop/functions/mazes/x74-4.mcfunction
	ruby maze.rb 25 25 random 105 > data/uberop/functions/mazes/x74-5.mcfunction

maze-pvp:
	border_block=black_concrete vwall=barrier hwall=barrier ruby maze.rb 20 20 random 100 > data/uberop/functions/maze-pvp/black.mcfunction
	border_block=red_concrete vwall=red_concrete hwall=black_stained_glass ruby maze.rb 20 20 random 99 > data/uberop/functions/maze-pvp/red.mcfunction
	border_block=orange_concrete vwall=orange_concrete hwall=black_stained_glass ruby maze.rb 20 20 random 101 > data/uberop/functions/maze-pvp/orange.mcfunction
	border_block=yellow_concrete vwall=yellow_concrete hwall=yellow_concrete ruby maze.rb 20 20 random 102 > data/uberop/functions/maze-pvp/yellow.mcfunction
	border_block=green_concrete vwall=green_concrete hwall=black_stained_glass ruby maze.rb 20 20 random 110 > data/uberop/functions/maze-pvp/green.mcfunction
	border_block=light_blue_concrete vwall=glass hwall=glass ruby maze.rb 20 20 random 104 > data/uberop/functions/maze-pvp/light_blue.mcfunction
