dist:
	git archive --format zip --output uberop.zip main

watch:
	find . -name '*.jinja' -o -name '*.py' | entr -c python compile.py


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
