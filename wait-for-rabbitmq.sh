#!/bin/bash

# Wait for RabbitMQ to be ready before continuing
while ! nc -z rabbitmq 5672; do
    sleep 1
done

echo "RabbitMQ is ready!"
