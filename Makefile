ifneq ($(wildcard /opt/homebrew/bin/pandoc),)
PANDOC := /opt/homebrew/bin/pandoc
else
PANDOC := pandoc
endif

all: site/index.html

sources/content.html: README.md
	$(PANDOC) $< -f markdown+implicit_figures -o $@

site/index.html: sources/header.html sources/content.html sources/footer.html
	cat $^ | sed -e 's|<h2|</div></section><section><div class="container"><h2|' > $@

push: all
	scp site/index.html site/stylesheet.custom.css falktx.berlin:~/sites/falktx/portfolio/
