include .env
PROJECT_NAME:=zip-unzip

build-nginx:
	$(eval IMAGE_NAME="ghcr.io/kharandziuk/${PROJECT_NAME}.nginx:latest")
	echo ${PAT} | docker login ghcr.io -u ${USER} --password-stdin;
	docker build -t ${IMAGE_NAME} nginx
	docker push ${IMAGE_NAME}
