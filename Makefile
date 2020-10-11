include .env
PROJECT_NAME:=zip-unzip

.PHONY: deploy

build-nginx:
	$(eval IMAGE_NAME="ghcr.io/kharandziuk/${PROJECT_NAME}.nginx:latest")
	echo ${PAT} | docker login ghcr.io -u ${GITHUB_USER} --password-stdin;
	docker build -t ${IMAGE_NAME} nginx
	docker push ${IMAGE_NAME}

start:
	docker-compose -f docker-compose.yml -f compose-files/docker-compose.override.yml up

start-prod:
	docker-compose -f docker-compose.yml -f compose-files/docker-compose.prod.override.yml up


deploy:
	ansible-galaxy install -r deploy/requirements.yml;
	ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook -v -i ${INSTANCE_IP}, --user ubuntu --private-key key_rsa deploy/playbook.yml \
	--extra-vars "registry_user=${GITHUB_USER} registry_token=${PAT} compose_file=compose_files/docker-compose.yml"
