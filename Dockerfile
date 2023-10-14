FROM python:3.9-alpine3.17
WORKDIR /flask_app
COPY . ${WORKDIR}
RUN apk update && apk add mariadb-dev pkg-config
RUN pip install mysqlclient
RUN pip install -r requirements.txt
EXPOSE 5000
CMD [ "python3", "app.py" ]
