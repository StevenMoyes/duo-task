# Use Python 3.6 as a base image
FROM python:3.6
# Copy contents into image
WORKDIR /app
# Install pip dependencies from requirements
COPY . .
RUN pip install -r requirements.txt
COPY . .
# Set YOUR_NAME environment variable
ENV YOUR_NAME="Steve"
# Expose the correct port
EXPOSE 5500
# Create an entrypoint
ENTRYPOINT [ "python", "app.py" ]