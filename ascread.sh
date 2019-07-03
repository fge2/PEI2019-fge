#!/bin/bash
#
#This function preprocesses .txt files to be read into and parsed by MATLAB as .asc files
#To iterate over files: for f in /path/to/*; do ./ascread.sh $f; done
#
#Last modified by fge@princeton.edu on 7/1/2019

filename=$1

sed '/0R0/!d; s/,/ /g; s/Dm=//g; s/Sm=//g; s/Ta=//g; s/Ua=//g; s/Pa=//g; s/Rc=//g; s/Hc=//g; s/D//g; s/M//g; s/C//g; s/P//g; s/B//g; s/\#//g; /cmd/d; /^[[:space:]]*$/d' $filename | awk -F' ' '{print $1,$6,$7,$8,$9,$10,$11,$12}' > ${filename%.txt}.asc
