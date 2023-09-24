ifneq ($(wildcard /opt/homebrew/bin/pandoc),)
PANDOC := /opt/homebrew/bin/pandoc
else
PANDOC := pandoc
endif

all: site/index.html

sources/content.html: README.md
	$(PANDOC) $< -f markdown+implicit_figures -o $@

site/index.html: sources/header.html sources/content.html sources/footer.html
	cat $^ \
		| sed -e 's|<h2 id="\(.*\)">|</div></section><section id="\1"><div class="container"><h2>|' \
		| sed -e 's|<figure>|<figure class="image fit">|' \
		> $@

push: all
	scp site/index.html site/stylesheet.custom.css falktx.berlin:~/sites/falktx/portfolio/
