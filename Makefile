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
	rsync -a static/dotcloud.yml _build/dotcloud.yml
	rsync -a --delete _build/ ../.develop-blog-www/
	dotcloud push notes ../.develop-blog-www/
	@echo "Done..."
