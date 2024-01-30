# celery_tasks.py
from celery import Celery
from spacy_functions import identify_entities

# Update the broker URL to point to your RabbitMQ container
# Replace 'guest', 'localhost', and '5672' with your RabbitMQ credentials and container hostname/IP
app = Celery('tasks', broker='pyamqp://admin:admin@3.85.100.0:5672//')

@app.task
def analyze_text(text, use_gpu=False):
    return identify_entities(text, use_gpu)
