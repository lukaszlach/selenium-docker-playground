JASMINE := node node_modules/jasmine/bin/jasmine.js

build:
	docker-compose build --pull
	docker-compose pull
	docker-compose run node npm install --save selenium-webdriver
	docker-compose run node npm install --save jasmine

clean: kill rm

start:
	docker-compose -p "selenium" up -d --force-recreate

stop:
	docker-compose stop

restart: stop start

respawn: kill start

kill:
	docker-compose kill

rm:
	docker-compose rm -f

logs:
	docker-compose logs -f

ps:
	find . -name "docker-compose*.yml" | xargs -n1 -I{} bash -c "echo -e '\n{}'; docker-compose -f {} ps"

test:
	docker-compose run node ${JASMINE} spec/test-01.js