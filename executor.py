#executor.py
from celery_tasks import analyze_text

result = analyze_text.delay("John Doe works at Acme Corp in New York.", use_gpu=True)
print(result)

