FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache postgresql-client 
#jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev 
      #musl-dev zlib zlib-dev
RUN python3.7 -m pip install -r /requirements.txt
RUN apk del .tmp-build-deps  

RUN mkdir /nowruzWebsite
WORKDIR /nowruzWebsite
COPY ./ /nowruzWebsite

RUN mkdir -p /vol/web/media
RUN mkdir -p /vol/web/static
RUN adduser -D user
RUN chown -R user:user /vol/
RUN chmod -R 755 /vol/web
USER user
