dist:
	git archive --format zip --output uberop.zip main

watch:
	find . -name '*.jinja' -o -name '*.py' | entr -c python compile.py
