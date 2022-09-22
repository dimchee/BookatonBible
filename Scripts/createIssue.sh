if [ -z "$(gh issue list -l LaTeX -S $1)" ]
then
	gh issue create --title "$1" --body "[Zadate stranice](../blob/main/Src/Pages/$1.tex)" --label LaTeX
    echo "Created Issue $1 :D"
else
    echo "Issue $1 already exists!" 
fi
