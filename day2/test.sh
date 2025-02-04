 #!/bin/env bash                                                               
                                                                              
listProcess() {                                                               
    declare -a list=($1)                                                      
    declare -i cont=0                                                         
    local comp
    local n=$(echo "${#list[@]}")
    #echo "${list[@]}"
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
    while IFS= read -r line; do                                               
        safe=$(listProcess "$line")                                                  
        if [ "$safe" == "safe" ];then
            ((total++))
        fi
    done < list
    echo $total
}                                                                             
                                                                              
main                                                                           
