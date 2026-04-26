# 1. Use a slim base image for a much smaller footprint
FROM python:3.9-slim

# 2. Add metadata labels
LABEL maintainer="Your Name <your.email@example.com>"
LABEL version="1.0"
LABEL description="Optimized Sakila Flask Application"

# 3. Create a non-root user for security
RUN groupadd -r appuser && useradd -r -g appuser appuser

# 4. Set the working directory
WORKDIR /app

# 5. Install curl (needed for the healthcheck)
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# 6. Copy ONLY requirements first to leverage Docker layer caching
COPY requirements.txt .

# 7. Install dependencies in a single layer
RUN pip install --no-cache-dir -r requirements.txt

# 8. Copy the rest of the application code
COPY . .

# 9. Change ownership of the app files to the non-root user
RUN chown -R appuser:appuser /app

# 10. Switch to the non-root user
USER appuser

# 11. Expose ONLY the necessary port
EXPOSE 5000

# 12. Add a Healthcheck to verify the app is running
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:5000/ || exit 1

# 13. Define the command to run the app
CMD ["python", "app.py"]