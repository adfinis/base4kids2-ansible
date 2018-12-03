#!/bin/bash

while read 
  do  
    awk ' { print "- name: "$2; 
            print "  sn: "$3;
            print "  klassen:";
            print "    - klasse: S9_a_2012/2013_Sonnenhof_Laubegg_Kirchenfeld-Schosshaldejj";
            print "    - klasse: S9_a_2012/2013_Sonnenhof_Laubegg_Kirchenfeld-Schosshalde_"$5;
            print "  mail: "$4;
            print "  uid: "$1;
            print "  password: \x27"$6 "\x27";
    }' 
done < users.csv
