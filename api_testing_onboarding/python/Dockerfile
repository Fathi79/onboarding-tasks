FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . ./python/

WORKDIR /app/python

ENV PYTHONPATH =/app

CMD ["python", "-m", "pytest", "tests/test_pet_api.py"]
