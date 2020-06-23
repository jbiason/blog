+++
title = "ElasticSearch"

[taxonomies]
tags = ["research", "elastic", "elasticsearch", "docker"]
+++

## Docker image

```
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.8.0
```

## Start

```
docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.8.0
```

- Port 9200: REST interface.
- Port 9300: Inter-node communication.
- `discovery.type`: Just one node, no discovery needed.

## Definitions

- MySQL => Databases => Tables => Columns/Rows
- Elasticsearch => Indices => Types => Documents with Properties

## Adding information (REST)

```
POST /<index>/_doc/
```
