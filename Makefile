all: site/index.html

sources/content.html: README.md
	/opt/homebrew/bin/pandoc $< -f markdown+implicit_figures -o $@

site/index.html: sources/header.html sources/content.html sources/footer.html
	cat $^ | sed -e 's|<h2|</div></section><section><div class="container"><h2|' > $@
