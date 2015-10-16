DOCKER_IMAGE_NAME=marclennox/rpi-dhcpd

clean_build: Dockerfile
	docker build --no-cache=true -t ${DOCKER_IMAGE_NAME} .

build: Dockerfile
	docker build -t ${DOCKER_IMAGE_NAME} .

push: build
	docker push ${DOCKER_IMAGE_NAME}
