#!/bin/bash

start_jupyter() {
    echo "Starting Spark History Server..."
    echo "Starting Jupyter Notebook..."
    $SPARK_HOME/sbin/start-history-server.sh && jupyter notebook --ip=0.0.0.0 --port=4041 --no-browser --NotebookApp.token='' --NotebookApp.password=''
}

start_spark_shell() {
    echo "Starting Spark Shell..."
    $SPARK_HOME/sbin/start-history-server.sh && spark-shell
}

start_pyspark_shell() {
    echo "Starting PySpark Shell..."
    unset PYSPARK_DRIVER_PYTHON
    unset PYSPARK_DRIVER_PYTHON_OPTS
    $SPARK_HOME/sbin/start-history-server.sh && pyspark
}

case "$1" in
    jupyter)
        start_jupyter
        ;;
    spark-shell)
        start_spark_shell
        ;;
    pyspark)
        start_pyspark_shell
        ;;
    *)
        echo "Usage: $0 {jupyter|spark-shell|pyspark}"
        exit 1
        ;;
esac
