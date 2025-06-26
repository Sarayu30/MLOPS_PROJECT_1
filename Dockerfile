FROM python:slim

# Environment variables to improve performance and avoid .pyc files
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy current directory contents into the container
COPY . .

# Install Python dependencies in editable mode
RUN pip install --no-cache-dir -e .

# Run training pipeline once during build (optional step, typically not recommended inside Dockerfile)
RUN python pipeline/training_pipeline.py

# Expose the port the app runs on
EXPOSE 5000

# Command to run the app
CMD ["python", "application.py"]
