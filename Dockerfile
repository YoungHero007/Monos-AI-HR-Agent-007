FROM python:3.13-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends curl fonts-dejavu && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./requirements.txt
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8501

HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=5 \
  CMD-SHELL curl --fail "http://localhost:${PORT:-8501}/_stcore/health" || exit 1

CMD ["sh", "start.sh"]
