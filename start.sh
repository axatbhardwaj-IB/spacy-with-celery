#!/bin/bash
. venv/bin/activate
celery -A celery_tasks worker --loglevel=info &
sleep 5
python executor.py
