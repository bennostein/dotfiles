$pdflatex = 'pdflatex -halt-on-error -synctex=1 %O %S';
$pdf_previewer = 'open -a skim';
$clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';
$ENV{max_print_line} = $log_wrap = 10000;