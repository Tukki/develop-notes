all: build upload

rm:
	find -name '*.rst~' | xargs rm

clean:
	rm -rf _build

build:
	run-rstblog build

serve:
	run-rstblog serve

upload:
	#rsync -a _build/ pocoo.org:/var/www/lucumr.pocoo.org/new/
	@echo "TODO ..."
