build:
	docker compose down --remove-orphans --volumes
	docker network prune -f
	docker compose up --build
