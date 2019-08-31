FROM python:3.7-alpine
ARG USER_ID

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apk add --no-cache bash
RUN apk add --no-cache git
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev


COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN apk del .tmp-build-deps

# Setup directory structure
WORKDIR /workspace/python
