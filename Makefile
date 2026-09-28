.PHONY: all clean view

all: homework.pdf template.pdf

%.pdf: %.tex homework.cls
	latexmk -xelatex -interaction=nonstopmode -halt-on-error -file-line-error $<

clean:
	latexmk -c
	rm -f *.xdv *.bbl *.blg

view: homework.pdf
	open homework.pdf
