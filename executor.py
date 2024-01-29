from celery_tasks import analyze_text

# Sending text to the task
result = analyze_text.delay("John Doe works at Acme Corp in New York.")
print(result)  # This will print the result once the task is completed
