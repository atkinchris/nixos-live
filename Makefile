build:
	./run.sh

list-cache:
	docker run --rm -it -v=nixoslive_cache:/cache alpine ls -al /cache
