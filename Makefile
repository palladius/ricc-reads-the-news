
run:
	bundle exec jekyll serve

install:
	bundle install

# https://juunone.github.io/juunflix/
install-jekflix:
	npm install -g gulp gulp-cli


push:
	git push origin gh-pages


download-stuff:
	git clone https://github.com/thiagorossener/jekflix-template vecchiume/jekflix-template-copy/ #tags-page
