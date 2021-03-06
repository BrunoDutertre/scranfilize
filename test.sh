#!/bin/sh

execute () {
  input=cnfs/${1}.cnf
  output=log/${1}-$2.cnf
  log=log/${1}-$2.log
  cmd="./scranfilize -s 0 $3 $input $output"
  echo "$cmd"
  $cmd 2>$log && return
  cat $log
  exit 1
}

run () {
  execute $1 default
  execute $1 same "-f 0 -v 0 -c 0"
  execute $1 flipped "-f 1"
  execute $1 permuted-variables "-p -f 0"
  execute $1 permuted-clauses "-P -f 0"
  execute $1 both-permuted "-p -P -f 0"
  execute $1 small "-f 0.125 -v 0.1 -c .1"
  execute $1 medium "-f 0.25 -v 0.5 -c 0.5"
  execute $1 high "-f 0.5 -v 1 -c 1"
  execute $1 absolute -a
  execute $1 reverse-variables -r
  execute $1 reverse-clauses -R
  execute $1 reverse-variables-and-clauses "-r -R"
}

[ -d log ] || mkdir log
rm -f log/*

run add4
run add8
run add16
run add32
