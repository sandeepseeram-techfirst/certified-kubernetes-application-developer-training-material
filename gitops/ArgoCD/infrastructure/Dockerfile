# Base Image
FROM python:3.8-slim-buster

RUN useradd -m seerams
ENV PATH="/home/seerams/.local/bin:${PATH}"
USER seerams

# Specify the working directory
WORKDIR /app

# Copy the file from the local directory to the container
COPY requirements.txt requirements.txt
RUN pip3 -q --disable-pip-version-check install --user -r requirements.txt

# Copy the content of the current directory on the file system into 
# the current directory on the container image.
COPY . . 

# Start the application and listen on all IPs
CMD [ "waitress-serve", "--port=5000", "--call", "app:create_app"]