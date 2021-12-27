$pdflatex = 'pdflatex -halt-on-error -synctex=1 %O %S';
$pdf_previewer = 'start xpdf -remote %R %O openFile\\(%S\\)';
$pdf_update_method = 4;
$pdf_update_command = "xpdf -remote %R reload";
$clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';
$ENV{max_print_line} = $log_wrap = 10000;

$compiling_cmd = 'zsh -c "echo -ne \"\033]0;COMPILING %D\a\""';
$success_cmd = 'zsh -c "echo -ne \"\033]0;%D SUCCESS\a\""';
$failure_cmd = 'zsh -c "echo -ne \"\033]0;%D FAILURE\a\""';
