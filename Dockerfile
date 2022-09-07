FROM ubuntu:18.04
ENV TZ=Europe/Moscow
RUN apt-get update && apt-get install -y tzdata && apt-get install -y git
RUN rm -rf /etc/localtime
RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
CMD echo "Hello, IAC"
