LANGUAGES=("en" "de" "fr" "es")

echo "Currently supported languages: ${LANGUAGES[@]}"
read -p "Please input the desired language code, or press ENTER to build all" lc

new-language-build () {
	local lc="$1"
	html="$lc"
	if [[ "en" == "$lc" ]]; then
		html="index"
	fi
    latexmk -pdf -outdir=pdfs -silent trans/$lc/pghrt_$lc
    latexmk -c -outdir=pdfs -silent trans/$lc/pghrt_$lc
    latexmlc --destination=export/$html.html trans/$lc/pghrt_$lc

    python soup.py $lc
}

for i in "${LANGUAGES[@]}"
do
    if [[ "$i" == "$lc" ]]; then
		found=1
		new-language-build "$lc"
    fi
done

if [ -z ${found+x} ]; then
	for i in "${LANGUAGES[@]}"
	do
		new-language-build "$i"
	done
fi
