.SUFFIXES: .tex .dvi .pdf

NAME 	= online-learning
PDF	= slide.pdf
SRC	= slide.tex
SUB	= $(shell ls main/*.tex)
GIF 	= thumbnail.gif

HUGO	= $(HOME)/Desktop/hugo/official/static

RSYNC	= /usr/bin/rsync -auv --delete \
		--exclude='.*' --exclude='*~' --exclude='_*'

MSG	= $(shell head -1 VERSION)
# to overwrite MGS, try make MSG="xxx" 

all:	$(PDF)

$(PDF):
	latexmk $(SRC)

clean:
	latexmk -C $(SRC)

view:
	open $(PDF)

# sync to hugo directory
hugo:
	$(RSYNC) $(PDF) $(HUGO)/pdfs/$(NAME).pdf
	$(RSYNC) $(GIF) $(HUGO)/pdfs/$(NAME).gif

thumbnail:
	convert -density 150 -delay 100 slide.pdf -thumbnail "600x600>" thumbnail.gif 

delay:
	mogrify -loop 0 -delay 200 thumbnail.gif

git-add:
	git add *.tex main/*.tex

push:
	git add -u
	git commit -m "${MSG}"
	git push -u origin main

stat:
	git status
