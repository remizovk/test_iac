FROM ubuntu:18.04
ENV TZ=Europe/Moscow
RUN apt-get update && apt-get install -y tzdata && apt-get install -y git
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
CMD echo "Hello, IAC"
