 #!/bin/env bash                                                               
                                                                              
listProcess() {                                                               
    declare -a list=($@)                                                      
    declare -i cont=0                                                         
    local comp
    local n=$(echo "${#list[@]}")
    #echo "<> ${list[0]} <<  ${list[$((n-1))]} << $n"
    if (( list[0] > list[$((n-1))] )); then                                    
        comp=true                                                             
    else                                                                      
        comp=false                                                            
    fi                                                                        
    while (( cont < $((n-1)) )); do                                                 
        local tmp                                                             
        if (( list[$cont] > list[$((cont+1))] )); then                      
            tmp=true                                                          
        else                                                                  
            tmp=false                                                         
        fi                                                                    
        local num=$(( list[$cont] - list[$((cont+1))] ))                    
        num=${num#-}                                                          
        if [ "$comp" = "$tmp" ]; then                                         
            if (( 1 <= num && num <= 3 )); then                               
                ((cont++))                                                    
            else                                                              
                break                                                         
            fi                                                                
        else                                                                  
            break                                                             
        fi                                                                    
    done                                                                      
    if (( cont == $((n-1)) )); then                                                  
        echo "safe"                                                           
    else                                                                      
        echo "not"                                                       
    fi                                                                        
}                                                                             
                                                                              
main() {                         
    local total=0
    while IFS= read -r cod; do      
        declare -a list
        list=()

        for num in $cod;do
            list+=( $(echo $num) )
        done

        declare -i n=$(echo "${#list[@]}")
        declare -a cplist=( "${list[@]}" )
        declare -i aux=0

        while (( aux <= n ));do
            echo -e "\ntest: ${cplist[@]}" 
            #listProcess "$(echo ${cplist[@]})"
            safe=$(listProcess "$(echo ${cplist[@]})")
            #listProcess "${cplist[@]}"
            #echo "rest: $safe" 
            if [ "$safe" == "safe" ];then
                ((total++))
                echo "safe"
                break
            else
                cplist=()
                for i in $(eval echo {0..$n});do
                    #echo "item $item - ${list[$aux]} "
                    if (( $i != $aux ));then
                        cplist+=(${list[$i]})
                    fi
                done
                ((aux++))
                #echo " nuevo ${cplist[@]}, aux: $aux"
            fi
        done
    done < list
    echo "Total safe: $total"
}                                                                             
                                                                              
main                                                                           
