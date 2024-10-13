limit=1000  
mkdir -p judge
g++ a.cpp -o judge/code -O2 -std=c++14 -W 
list=`ls ./*out 2> judge/err.txt`
for out in $list; do 
	ans=`echo $out | sed "s/\.out/\.ans/"`
	mv $out $ans
done
list=`ls ./*in`
for in in $list; do 
	name=`echo $in | sed "s/\.in/\ /"`; name=`echo $name | sed "s/\.\//\ /"`
	ans=`echo $in | sed "s/\.in/\.ans/"`
	out=`echo $in | sed "s/\.in/\.out/"`
	res=`echo $in | sed "s/\.in/\.res/"`
	start=`date +%s%N`
	./judge/code < $in > $out
	end=`date +%s%N`
	used=$(((end-start)/1000000))
	diff -bBw $out $ans > $res 
    result=$?    
    if [ $result -ne 0 ]; then  
        echo -e "Test Case$name: \e[31mWrong Answer\e[0m ($used ms)"  
    elif [ $used -le $limit ]; then  
        echo -e "Test Case$name: \e[32mAccepted\e[0m ($used ms)"  
    else  
        echo -e "Test Case$name: \e[36mTime Limit Exceeded\e[0m ($used ms)"  
	fi  
done