from celery import Celery
from spacy_functions import identify_entities

# Initialize Celery
app = Celery('tasks', broker='pyamqp://guest@localhost//')

@app.task
def analyze_text(text):
    return identify_entities(text)
