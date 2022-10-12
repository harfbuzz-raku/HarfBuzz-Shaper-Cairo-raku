SRC=src
DocProj=pdf-raku.github.io
DocRepo=https://github.com/pdf-raku/$(DocProj)
DocLinker=../$(DocProj)/etc/resolve-links.raku

all :

docs/index.md : README.md
	cp $< $@

docs/%.md : lib/%.rakumod
	@raku -I . -c $<
	raku -I . --doc=Markdown $< \
	| TRAIL=$* raku -p -n $(DocLinker) \
        > $@

README.md : lib/HarfBuzz/Shaper/Cairo.rakumod
	@raku -I . -c $<
	raku -I . --doc=Markdown $< \
	| TRAIL=HarfBuzz/Shaper/Cairo raku -p -n  $(DocLinker) \
        > $@

$(DocLinker) :
	(cd .. && git clone $(DocRepo) $(DocProj))

Pod-To-Markdown-installed :
	@raku -M Pod::To::Markdown -c

doc : $(DocLinker) Pod-To-Markdown-installed README.md docs/index.md docs/HarfBuzz/Font/Cairo.md

test : all
	@prove6 -I . t

loudtest : all
	@prove6 -I . -v t

clean :
	echo cleaned

realclean : clean
	@rm -f Makefile README.md docs/*.md


