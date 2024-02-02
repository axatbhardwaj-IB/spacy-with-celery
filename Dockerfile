FROM nvidia/cuda:11.0-base

# Install Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Install Celery and spaCy
RUN pip3 install celery spacy

# Download the spaCy English model
RUN python3 -m spacy download en_core_web_sm

# Copy the Celery task script
COPY celery_tasks.py /celery_tasks.py

# Set the default command to run Celery worker
CMD ["celery", "-A", "celery_tasks", "worker", "--loglevel=info"]


