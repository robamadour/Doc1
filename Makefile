############################ -*- Mode: Makefile -*- ###########################
## Makefile --- Makefile for Thesis Manuscript.
##
## Author          : Miguel Torres-Torriti
## Created         : Tue 01 Apr 2003 - 16:30
## Last modified   : Tue 01 Apr 2003 - 16:30
###############################################################################

# Your manuscript 'filename.tex' file.
FILENAME   = puctesis
PRINTEROPS = -Plj1

all: 
#	tex -> dvi
	latex $(FILENAME)_plantilla.tex
	latex $(FILENAME)_ejemplo.tex
	bibtex $(FILENAME)_plantilla.tex
	bibtex $(FILENAME)_ejemplo.tex
	latex $(FILENAME)_plantilla.tex
	latex $(FILENAME)_ejemplo.tex
	latex $(FILENAME)_plantilla.tex
	latex $(FILENAME)_ejemplo.tex
#	dvi -> ps on Windows
#	dvips -o $(FILENAME).ps -t letter -t landscape $(FILENAME).dvi
#	dvips -o $(FILENAME).ps -t letter $(FILENAME).dvi
#	dvips -o $(FILENAME)_plantilla.ps -t letter -$(FILENAME)_plantilla.dvi
#       dvi -> ps on Unix
#	dvips -o $(FILENAME).ps -t letter -t landscape -Ppdf -G0 $(FILENAME).dvi
#	dvips -o $(FILENAME).ps -t letter -Ppdf -G0 $(FILENAME).dvi
	dvips -t letter -Ppdf -G0 $(FILENAME)_plantilla.dvi -o $(FILENAME)_plantilla.ps
	dvips -t letter -Ppdf -G0 $(FILENAME)_ejemplo.dvi -o $(FILENAME)_ejemplo.ps
#	ps -> pdf
#	ps2pdf -sPAPERSIZE=letter $(FILENAME).ps
	ps2pdf -sPAPERSIZE=letter -dEmbedAllFonts=true -dPDFSETTINGS=/prepress $(FILENAME)_plantilla.ps $(FILENAME)_plantilla.pdf
	ps2pdf -sPAPERSIZE=letter -dEmbedAllFonts=true -dPDFSETTINGS=/prepress $(FILENAME)_ejemplo.ps $(FILENAME)_ejemplo.pdf
#	make clean
#
# Alternatively,
#all:	
#	make latex
#	make latex
#	make dvips
#	make ps2pdf
#	make clean

postscript-bw:
	echo -e "n\ny" | make latex
	echo -e "n\ny" | make latex
	make dvips

postscript-color:
	echo -e "y\ny" | make latex
	echo -e "y\ny" | make latex
	make dvips

pdf-bw:
	echo -e "n\nn" | make latex
	echo -e "n\nn" | make latex
	make thumb
	echo -e "n\nn" | make latex
	make dvi2pdf
	make clean

pdf-color:
	echo -e "y\nn" | make latex
	echo -e "y\nn" | make latex
#	make thumb
#	echo -e "y\nn" | make latex
	make dvi2pdf
	make clean

postscript:
	make postscript-bw

pdf:
	make pdf-color

postscript-draft:
	echo -e "n\ny" | make latex
	make dvips

pdf-draft:
	echo -e "y\nn" | make latex
	make dvi2pdf

latex:
	latex $(FILENAME).tex

dvi2pdf:
	make dvips
	make ps2pdf

dvips:
	dvips -o $(FILENAME).ps -t letter -t landscape -Ppdf -G0 $(FILENAME).dvi

ps2pdf:
#	ps2pdf -sPAPERSIZE=archA $(FILENAME).ps
	ps2pdf -sPAPERSIZE=letter $(FILENAME).ps
#	ps2pdf -sPAPERSIZE=a4 $(FILENAME).ps

thumb:
	make dvi2pdf
	thumbpdf.pl --modes=dvips $(FILENAME).pdf

mpage1:
	mpage -1 -v -a -k -b A4 $(FILENAME).ps > $(FILENAME)_1.ps
	gzip --force $(FILENAME)_1.ps
	chmod 644 $(FILENAME)_1.ps.gz

mpage2:
	pstops 2:1,0 $(FILENAME).ps | mpage -2 -v -a -k -b A4 > $(FILENAME)_2.ps
	gzip --force $(FILENAME)_2.ps
	chmod 644 $(FILENAME)_2.ps.gz

mpage4:
	pstops 4:2,0,3,1 $(FILENAME).ps | mpage -4 -v -a -k -b A4 > $(FILENAME)_4.ps
	gzip --force $(FILENAME)_4.ps
	chmod 644 $(FILENAME)_4.ps.gz

lpr:
	zcat $(FILENAME)_4.ps.gz | lpr $(PRINTEROPS)

distrib:
	make postscript-bw
#	make mpage4
	make pdf-color
#	make distrib-source-tar
	make distrib-tar
	make clean
	rm -f $(FILENAME).ps

clean:
	rm -f $(FILENAME)_plantilla.{aux,toc,lof,lot,log,dvi,ps,bbl,blg}
	rm -f $(FILENAME)_ejemplo.{aux,toc,lof,lot,log,dvi,ps,bbl,blg}

cleanall:
	make clean
#	rm -f $(FILENAME).{ps,ps.gz,_1.ps.gz,_2.ps.gz,_4.ps.gz,pdf}
