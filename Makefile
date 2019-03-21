CONTAINER  = mpd
DOCKER_RUN = docker run --rm -it $(CONTAINER)


get-src:
	git clone git@github.com:MusicPlayerDaemon/MPD.git mpd_src

docker-clean clean:
	-docker stop $(CONTAINER)
	-docker rm -f $(CONTAINER)

docker-build build:
	docker build -t $(CONTAINER) .

docker-run run:
	$(DOCKER_RUN)

docker-shell shell:
	$(DOCKER_RUN) bash

