FROM python:3.6.4-alpine3.7
COPY ./requirements.txt /usr/src
WORKDIR /usr/src
RUN pip install -r requirements.txt
WORKDIR /usr/src/app
#WORKDIR /usr/src
#RUN pip install -r requirements.txt
#WORKDIR /usr/src/app/src
CMD [ "python", "./app.py" ]
