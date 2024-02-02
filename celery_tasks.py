# celery_tasks.py
from celery import Celery
from spacy_functions import identify_entities

# Initialize Celery with additional configuration options
app = Celery('tasks', broker='pyamqp://guest@localhost//', track_started=True)

@app.task
def analyze_text(text_content):
    return identify_entities(text_content)
