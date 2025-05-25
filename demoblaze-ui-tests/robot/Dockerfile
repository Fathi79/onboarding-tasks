FROM python:3.13.3-slim

WORKDIR /app

# Install Chromium, Chromedriver and dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-driver \
    fonts-liberation \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    libgbm1 \
    libpangocairo-1.0-0 && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements and install Robot Framework + SeleniumLibrary etc.
COPY requirements.txt .
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copy your Robot Framework test files and keywords
COPY . .

# Set PYTHONPATH if you use Python keywords or libs
ENV PYTHONPATH=/app

# Tell Robot Framework where to find the test suite and generate reports
CMD ["robot", "--outputdir", "reports", "tests/test_demoblaze.robot"]
