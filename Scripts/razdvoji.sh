Book='The Holy Bible - King James Version.pdf'
Step=5
Pages=$(pdftk "$Book" dump_data | grep "NumberOfPages" | cut -d " " -f2)

mkdir -p Delovi

# First delete all labels
gh label list | awk -F '\t' '{ print $1 }' | xargs -I _ gh label delete --confirm '_'

# Create labels for common things
gh label create LaTeX --description "Potrebno je prekucati text u LaTeX" --color D93F0B
gh label create Tikz  --description "Potrebno je pretvoriti sliku u LaTeX" --color E99695

for i in $(seq 0 $(($Pages / $Step)))
do
	poc=$(($Step * $i + 1))
	poc=$(($poc - ($i > 0 ? 1 : 0))) # get pages overlapped
	end=$(($Step * ($i + 1)))
	end=$(($end < $Pages ? $end : $Pages)) # shouldn't go after last page
	name=$(printf '%04d-%04d' $poc $end) 
	file="Delovi/$name.pdf"
	echo "Izdvajam " $file
	pdftk "$Book" cat $poc-$end output $file
	echo "Pravim Github issue " $name
	gh issue create --title "$name" --body "[Stranice](../blob/main/$file)" --label LaTeX
done
echo "Gotovo :D"

