#gmx trjconv -s ../VIZ/ABI1-ROP11-30.tpr -f ABI1-ROP11-30-rnd7.part0007.xtc -pbc nojump -o nojump.xtc
#gmx trjconv -s ../VIZ/ABI1-ROP11-30.tpr -f nojump.xtc -pbc whole -o whole.xtc
#gmx trjconv -s ../VIZ/ABI1-ROP11-30.tpr -f whole.xtc -fit rot+trans -o output.xtc

gmx trjconv -s ../VIZ/ABI1-ROP11-30.tpr -f ABI1-ROP11-30-rnd7.part0007.xtc -pbc nojump -o nojump.xtc
gmx trjconv -s ../VIZ/ABI1-ROP11-30.tpr -f nojump.xtc -center -n ABI1-ROP11-30.ndx -o test.xtc
gmx trjconv -s ../VIZ/ABI1-ROP11-30.tpr -f test-output.xtc -o test-compact.xtc -pbc mol -ur rect
gmx trjconv -s ../VIZ/ABI1-ROP11-30.tpr -f test-compact.xtc -o test-fit.xtc -fit progressive
