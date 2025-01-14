
run:
	bundle exec jekyll serve

install:
	bundle install

# https://juunone.github.io/juunflix/
install-jekflix:
	npm install -g gulp gulp-cli


push:
	git push origin gh-pages
