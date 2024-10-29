FROM python:3.10-slim

# Set the working directory for the application
WORKDIR /code

# Copy requirements file and install dependencies
COPY ./requirements.txt /code/requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Create a non-root user and switch to that user
RUN useradd -m user  # -m creates a home directory for the user
USER user

# Set environment variables
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Set the application working directory
WORKDIR $HOME/app

# Copy application code with the appropriate ownership
COPY --chown=user:user . $HOME/app
EXPOSE 7860


# Command to run the application
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]