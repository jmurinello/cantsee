#!/bin/bash

counter=0 #number of intervals spent working; resets every set
intervals=4 #total of intervals per set
sets=0

# lenghts in seconds
interval_lenght=1500
short_break_lenght=300
longer_break_lenght=900

min_brightness=0
max_brightness=0.5

show_info() {
  clear
  printf "$(basename $0 .sh) version v0.1.0\n";
  printf "Sets completed: $sets\n";
  if [[ $counter -ne 0 ]]; then
    printf "[$counter/$intervals] Intervals...\n";
  fi
}

start_interval() {
  ((counter+=1))
  show_info
  sleep $interval_lenght;
  brightness $min_brightness;
  if [[ $counter -eq $intervals ]]; then
    sleep $longer_break_lenght;
    ((counter=0))
    ((sets+=1))
    show_info
  else
    sleep $short_break_lenght;
  fi
  brightness $max_brightness;
}

main() {
  show_info
  while true; do
    read -p "Do you want to continue? (y/n) " yn
    case $yn in
      [Yy])
        start_interval
        continue
        ;;
      [Nn])
        printf "Bye!\n\n"
        break
        ;;
      *)
        printf "usage ${0##*/}: {y|n}\n"
        continue
        ;;
    esac
  done
}

main
