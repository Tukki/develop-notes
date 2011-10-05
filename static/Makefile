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
	#rsync -a --delete _build/ ../public/
	rsync -a static/dotcloud.yml _build/dotcloud.yml
	dotcloud push notes _build/
	@echo "Done..."
