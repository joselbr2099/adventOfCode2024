#! /bin/env bash

# declare list
declare -a list1=()
declare -a list2=()

# sort list function
getList(){
  list1=( $(cat input2 | awk '{print $1}' ) )  
}

contNum(){
  cat input2 | awk '{print $2}'  | grep "$1" | wc -l 
}

main(){
  
  getList

  # get lenght of list
  n=$(echo "${#list1[@]}")
  declare -i c=0
  declare -i sum=0
  declare -i tmp=0

  # ${d#-} to get abs 
  while [ $c -le $n ];do
    tmp=$( contNum  "${list1[$c]}" )
    ((sum+=$(( list1[$c] * tmp )) )) 
    ((c++))
  done
  echo "second part: $sum"

}

main "$@"

# one liner
# $ tmp=0;sum=0;for num in $(cat input2 | awk '{print $1}');do tmp=$(cat input2 | awk '{print $2}' | grep $num |wc -l);sum=$(( sum + $(( $num * $tmp )) ));done
