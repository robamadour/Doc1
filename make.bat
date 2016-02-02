latex puctesis_plantilla
bibtex puctesis_plantilla
latex puctesis_plantilla
latex puctesis_plantilla
latex puctesis_ejemplo
bibtex puctesis_ejemplo
latex puctesis_ejemplo
latex puctesis_ejemplo
@REM dvips -t letter -Ppdf -G0 thpres.dvi -o thpres.ps
@dvips -t letter -t landscape thpres.dvi -o thpres.ps
dvips -t letter -Ppdf -G0 puctesis_plantilla.dvi -o puctesis_plantilla.ps
dvips -t letter -Ppdf -G0 puctesis_ejemplo.dvi -o puctesis_ejemplo.ps
@REM ps2pdf -sPAPERSIZE=letter thpres.ps thpres.pdf
@REM ps2pdf -sPAPERSIZE#letter -dPDFSETTINGS=/default puctesis_ejemplo.ps
ps2pdf -sPAPERSIZE#letter -dEmbedAllFonts#true -dPDFSETTINGS#/prepress puctesis_plantilla.ps puctesis_plantilla.pdf
ps2pdf -sPAPERSIZE#letter -dEmbedAllFonts#true -dPDFSETTINGS#/prepress puctesis_ejemplo.ps puctesis_ejemplo.pdf
@REM clean stuff
del *.aux
del *.toc
del *.lof
del *.lot
del *.log
del *.dvi
del *.bbl
del *.blg
del puctesis*.ps
del *.out