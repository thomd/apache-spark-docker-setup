# Apache Spark Setup with Docker

This is a Apache Spark setup runing in a Docker Container for learning purposes.

## Setup

    docker build -t spark .

## Jupyter Notebook

    docker-compose up -d jupyter
    open http://localhost:4041
    open http://localhost:4040/jobs/
    open http://localhost:18080/

## Spark Shell

    docker run --rm -d --name spark-shell -p 4040:4040 -p 4041:4041 -p 18080:18080 \
    -v $(pwd)/notebooks:/home/sparkuser/app -v $(pwd)/notebooks/event_logs:/home/spark/event_logs spark:latest spark-shell

or

    docker-compose up -d spark-shell

## PySpark

    docker run --rm -d --name pyspark -p 4040:4040 -p 4041:4041 -p 18080:18080 \
    -v $(pwd)/notebooks:/home/sparkuser/app -v $(pwd)/notebooks/event_logs:/home/spark/event_logs spark:latest pyspark

or

    docker-compose up -d pyspark
