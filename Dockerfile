# Step 1: Choose base image
FROM ubuntu:latest

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy requirements file first (for caching)
COPY requirements.txt .

# Step 4: Copy source code
COPY devops/ .

# Step 5: Install Python and dependencies
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Step 6: Install Python dependencies (with --break-system-packages flag)
RUN pip3 install --break-system-packages -r requirements.txt

# Step 7: Expose port
EXPOSE 8000

# Step 8: Define startup command
ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
