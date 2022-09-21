Book='The Holy Bible - King James Version.pdf'
Step=5
Pages=$(pdftk "$Book" dump_data | grep "NumberOfPages" | cut -d " " -f2)

mkdir -p Delovi
for i in $(seq 0 $(($Pages / $Step)))
do
	poc=$(($Step * $i + 1))
	poc=$(($poc - ($i > 0 ? 1 : 0))) # get pages overlapped
	end=$(($Step * ($i + 1)))
	end=$(($end < $Pages ? $end : $Pages)) # shouldn't go after last page
	name=$(printf '%04d-%04d.pdf' $poc $end) 
	echo "Pravim: " $name
	pdftk "$Book" cat $poc-$end output Delovi/$name
done
echo "Gotovo :D"

#gh issue create --title "Issue title" --body "Issue body"
