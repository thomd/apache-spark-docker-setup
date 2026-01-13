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

    docker run -it --entrypoint /bin/bash spark
    spark-shell

Inside Shell:

    :help
    :type sc
    :type spark


## PySpark

    docker run -it -v $(pwd)/notebooks:/home/sparkuser/app --entrypoint /bin/bash spark
    pyspark

Inside Python:

    textFile = spark.read.text("data.txt")
    textFile.count()
    textFile.first()
    textFile.filter(textFile.value.contains("Spark")).count()

