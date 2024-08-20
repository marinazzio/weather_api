DOCKER_COMPOSE_FILE = docker-compose.yml

all: build up

build:
	docker-compose -f $(DOCKER_COMPOSE_FILE) build

up:
	docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down

test:
	docker-compose -f $(DOCKER_COMPOSE_FILE) run --rm web bundle exec rspec

clean:
	docker-compose -f $(DOCKER_COMPOSE_FILE) down -v
	docker system prune -f
