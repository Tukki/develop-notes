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
	rsync -a --delete _build/ ../dotcloud-public/
	cp static/dotcloud.yml ../dotcloud-public/dotcloud.yml
	dotcloud push notes ../dotcloud-public/
	@echo "Done..."
