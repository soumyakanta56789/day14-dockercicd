FROM python:3.12-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1

WORKDIR /app

# 1. Create the system user first
RUN useradd --system --uid 10001 app

# 2. Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 3. Fix: Use --chown to give the 'app' user ownership of the application file
COPY --chown=app:app app.py .

USER app
EXPOSE 5000
CMD ["python", "app.py"]

