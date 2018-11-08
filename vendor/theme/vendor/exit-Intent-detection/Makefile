JSMIN = closure-compiler

all: min

min: jquery.exitintent.min.js

jquery.exitintent.min.js: jquery.exitintent.js
	$(JSMIN) < $? > $@

clean:
	rm -f *~

.PHONY: all min clean
