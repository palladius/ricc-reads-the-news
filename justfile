
# lists all targets
list:
    just -l

default:
	just --list

test:
	bundle exec ruby -I lib:test test/posts_test.rb
