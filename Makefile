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
	#rsync -a static/dotcloud.yml _build/dotcloud.yml
	rsync -a --delete _build/ ../.develop-blog-www/
	#dotcloud push  ../.develop-blog-www/
	git co gh-pages
	rm * -rf
	mv ../.develop-blog-www/develop-notes/* .
	#git add .
	#git ci -m 'news publish'
	#git push
	@echo "Done..."
