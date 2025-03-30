FROM python:3.10-slim

WORKDIR /app

# Install system packages required by Chromium
RUN apt-get update && apt-get install -y \
    wget gnupg unzip curl fonts-liberation libnss3 libxss1 libasound2 \
    libatk1.0-0 libatk-bridge2.0-0 libcups2 libxcomposite1 libxdamage1 \
    libxrandr2 libgbm-dev libgtk-3-0 libxshmfence-dev libx11-xcb-dev \
    && apt-get clean

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright and browsers (with system dependencies)
RUN playwright install --with-deps

# Copy app code
COPY . .

EXPOSE 8000
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
