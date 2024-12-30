#! /bin/env bash

# declare list
declare -a list1=()
declare -a list2=()

# sort list function
sortlist(){
  list1=( $(cat "$1" | awk '{print $1}' | sort -n) )  
  list2=( $(cat "$1" | awk '{print $2}' | sort -n) )  
}

main(){

  # get sorted list
  sortlist "input"
  
  # get lenght of list
  n=$(echo "${#list1[@]}")
  declare -i c=0
  declare -i sum=0

  # ${d#-} to get abs 
  while [ $c -le $n ];do
    d=$(( list1[$c] - list2[$c] )) 
    ((sum+=${d#-} ))
    ((c++))
  done
  echo "first part: $sum"


}

main "$@"
