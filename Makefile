.PHONY: all clean view

all: main.pdf

%.pdf: %.tex homework.cls
	latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error $<

clean:
	latexmk -c
	rm -f *.xdv *.bbl *.blg

view: main.pdf
	open main.pdf
