.PHONY: up down sql-client ps

up:
	docker compose -f docker-compose.yml up -d

down:
	docker compose -f docker-compose.yml down -v

ps:
	docker compose -f docker-compose.yml ps

sql-client:
	docker compose -f docker-compose.yml exec -it openmldb-api /opt/openmldb/bin/openmldb --role=sql_client --zk_cluster=openmldb-zk:2181 --zk_root_path=/openmldb
