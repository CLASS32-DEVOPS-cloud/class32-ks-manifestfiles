# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP=app.py
ENV FLASK_ENV=production
ENV PORT=6000

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Download gallery images
RUN mkdir -p app/static/images
RUN wget -O app/static/images/enroll-now.jpg https://github.com/projects-canada/images/raw/main/enroll%20now%20.jpg
RUN wget -O app/static/images/icon-3.png https://github.com/projects-canada/images/raw/main/icon%203.png
RUN wget -O app/static/images/the-team.jpg https://github.com/projects-canada/images/raw/main/the-team.jpg
RUN wget -O app/static/images/cyber-security.jpeg https://github.com/projects-canada/images/raw/main/CYBER%20SECURITY.jpeg
RUN wget -O app/static/images/graduautes.jpg https://github.com/projects-canada/images/raw/main/graduautes%20.jpg

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Make port 6000 available to the world outside this container
EXPOSE 6000

# Run the application
CMD ["python", "app.py"]