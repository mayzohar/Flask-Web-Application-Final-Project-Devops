FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# התקנות
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# קוד
COPY . .

# Flask צריך להאזין החוצה כשזה בקונטיינר
EXPOSE 5000
CMD ["python", "app.py"]

