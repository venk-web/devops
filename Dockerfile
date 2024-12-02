# Use a lightweight base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy the application code
COPY app.py .

# Install dependencies
RUN pip install flask

# Expose port 5000 to access the app
EXPOSE 5000

# Set the command to run the Flask application
CMD ["python", "app.py"]
