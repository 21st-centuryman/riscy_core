#cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib); cpanm Switch
iverilog -o run -g2005-sv $1
vvp run
gtkwave sim.vcd
