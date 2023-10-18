ifneq ($(wildcard /opt/homebrew/bin/pandoc),)
PANDOC := /opt/homebrew/bin/pandoc
else
PANDOC := pandoc
endif

all: site/index.html

sources/content.html: README.md
	cat $< | sed -n '5,6!p' | $(PANDOC) -f markdown+implicit_figures -o $@

site/index.html: sources/header.html sources/content.html sources/footer.html
	cat $^ \
		| sed -e 's|<h2 id="\(.*\)">|</div></section><section id="\1"><div class="container"><h2>|' \
		| sed -e 's|<img src|<img class="image fit" src|' \
		> $@

push: all
	scp site/index.html site/stylesheet.custom.css falktx.berlin:~/sites/falktx/portfolio/

pdf: portfolio.pdf

portfolio.pdf: README.md
	cat $< | sed 's/Hi there 👋 Welcome to my profile page! 🤓/falkTX Portfolio/' | sed -n '6,11!p' | $(PANDOC) \
		--pdf-engine=xelatex \
		-V 'geometry:margin=2cm' \
		-V 'mainfont:DejaVuSans' \
		-f markdown+implicit_figures -o $@
