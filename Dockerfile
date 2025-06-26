# Python image
FROM python:3.12-slim

# Env vars
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Workdir
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project
COPY . .

# Collect static
RUN python manage.py collectstatic --noinput

# Run with gunicorn
CMD ["gunicorn", "fakeUSGenerator.wsgi:application", "--bind", "0.0.0.0:8000"]
