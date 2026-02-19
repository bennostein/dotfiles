$pdflatex = 'pdflatex -halt-on-error -synctex=1 %O %S';
$pdf_previewer = 'open -a Preview %S';
$pdf_update_method = 0;
$clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';
$ENV{max_print_line} = $log_wrap = 10000;

$compiling_cmd = 'zsh -c "echo -ne \"\033]0;[LATEXMK] COMPILING %D\a\""';
$success_cmd = 'zsh -c "echo -ne \"\033]0;[LATEXMK] %D SUCCESS\a\""';
$failure_cmd = 'zsh -c "echo -ne \"\033]0;%D [LATEXMK] FAILURE\a\""';
