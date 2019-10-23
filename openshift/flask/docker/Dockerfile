FROM ubuntu:16.04

RUN apt-get update && apt-get install -y python python-pip

RUN pip install flask gunicorn

RUN useradd -ms /bin/bash app

WORKDIR /home/app

COPY server.py /home/app

EXPOSE 8080

USER ${user}

CMD ["gunicorn", "server:app", "-b", "0.0.0.0:8080", "--log-file", "-", "--access-logfile", "-", "--workers", "3", "--keep-alive", "0"]
