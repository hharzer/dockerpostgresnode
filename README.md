# dockerpostgresnode

Create single postgres db node using docker

Some commands:

docker build -t postgres_node .

docker build --no-cache -t postgres_node .

docker run --rm -P --name pg_node postgres_node

docker run --rm -P --name pg_node -v pg_data:/var/lib/postgresql postgres_node

docker run --rm --volumes-from pg_node -t -i busybox sh

docker run --rm -P --name pg_node postgres_node --build-arg ...

docker run --rm -p 5432:5432 --name pg_node postgres_node

docker run --rm -p 5432:5432 --name pg_node -v pg_data:/var/lib/postgresql postgres_node
