$pdflatex = 'pdflatex -halt-on-error -synctex=1 %O %S';
$pdf_previewer = 'open -a skim';
$clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';
$ENV{max_print_line} = $log_wrap = 10000;

$compiling_cmd = 'zsh -c "echo -ne \"\e]1;COMPILING %D\a\""';
$success_cmd = 'zsh -c "echo -ne \"\e]1;%D SUCCESS\a\""';
$failure_cmd = 'zsh -c "echo -ne \"\e]1;%D FAILURE\a\""';
