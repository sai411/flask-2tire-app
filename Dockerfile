FROM ubuntu:latest
WORKDIR /flask-app
COPY . .
RUN apt-get update && apt-get -y install python3 && apt-get -y install pip \
&& apt-get -y install python3-dev libmysqlclient-dev pkg-config
RUN pip install mysqlclient 
RUN pip install -r requirements.txt
CMD [ "python3", "app.py" ]
