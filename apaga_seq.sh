for OUTPUT_NUMBER in $(seq 1 8)
do
 { printf "practica\ncos\n1\n$OUTPUT_NUMBER\n2\nyes\n\n\033\0334\n"; sleep 2; } | telnet pdujupiter.disca.upv.es
done
