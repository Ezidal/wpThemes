DOCKER_COMPOSE_TASK = ./DockerComposeTask/docker-compose.yml

up:
	docker compose -f $(DOCKER_COMPOSE_TASK) up -d

login:
	docker exec wordpress /bin/sh -c "\
		docker-entrypoint.sh apache2-foreground & \
		sleep 7 && \
		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
		chmod +x wp-cli.phar && \
		mv wp-cli.phar /usr/local/bin/wp && \
		wp core install --url=localhost --title=\"site\" --admin_user=test --admin_password=\"test\" --admin_email=test@test.test --allow-root && \
		echo 'Установка плагина Redis...' && \
		wp plugin install redis-cache --activate --allow-root && \
		echo 'Включение Redis...' && \
		wp redis enable --allow-root && \
		chown -R www-data:www-data /var/www/html/ && \
		wp plugin install daggerhart-openid-connect-generic --activate --allow-root && \
		echo 'Настройка завершена!' && \
		wait \
	"
	
down:
	docker compose -f $(DOCKER_COMPOSE_TASK) down

restart: down up

encrypt:
	docker run --rm -d --name ansible cytopia/ansible sleep infinity
	docker cp ./DockerComposeTask/.env ansible:/data/.env2
	docker cp ./.key ansible:/data/.key
	docker exec ansible sh -c "ansible-vault encrypt .env2 --vault-password-file .key"
	docker cp ansible:/data/.env2 ./DockerComposeTask/.env-crypt
	rm ./DockerComposeTask/.env
	docker kill ansible

decrypt:
	docker run --rm -d --name ansible cytopia/ansible sleep infinity
	docker cp ./DockerComposeTask/.env-crypt ansible:/data/.env2
	docker cp ./.key ansible:/data/.key
	docker exec ansible sh -c "ansible-vault decrypt .env2 --vault-password-file .key"
	docker cp ansible:/data/.env2 ./DockerComposeTask/.env
	rm ./DockerComposeTask/.env-crypt
	docker kill ansible