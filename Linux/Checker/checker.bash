limit=1000  
mkdir -p check    
g++ gen.cpp -o check/gen -O2 -std=c++14 -W 
g++ code.cpp -o check/code -O2 -std=c++14 -W 
g++ brute.cpp -o check/brute -O2 -std=c++14 -W  
cd check   
count=0  
while true; do  
    ./gen > in.txt  
	start=`date +%s%N`  
	./code < in.txt > out.txt
	end=`date +%s%N`
	used=$(((end-start)/1000000))
    ./brute < in.txt > ans.txt  
    ((count++))  
    diff -bBw out.txt ans.txt > res.txt  
    result=$?    
    if [ $result -ne 0 ]; then  
        echo -e "Test Case #$count: \e[31mWrong Answer\e[0m ($used ms)"  
        break  
    elif [ $used -le $limit ]; then  
        echo -e "Test Case #$count: \e[32mAccepted\e[0m ($used ms)"  
    else  
        echo -e "Test Case #$count: \e[36mTime Limit Exceeded\e[0m ($used ms)"  
        break  
    fi  
done  