FILE_BASENAME=wcmp-1.3-kpi

html:
	asciidoctor --trace -o ${FILE_BASENAME}.html index.adoc
pdf:
	asciidoctor --trace -r asciidoctor-pdf --trace -b pdf -o ${FILE_BASENAME}.pdf index.adoc

linkcheck:
	find . -name "???.adoc" -exec asciidoc-link-check -p -c ./asciidoc-link-check-config.json {} \;

.PHONY: html pdf linkcheck
