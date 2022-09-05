## Задание  
1. Написать docker-файл для контейнера, который выводит в поток стандартного вывода "Hello, IAC".  
- В качестве базового образа использовать Ubuntu 18.  
- Установить временную зону Europe/Moscow внутри контейнера.  
- Установить git внутри контейнера.  

2. Выложить Dockerfile в публичный репозиторий на gitlab.com.  
- README.md указать команду для запуска контейнера. Так же добавить в репозиторий скриншот выполненной команды.  
## Написание Dockerfile 
1. Чтобы собрать свой образ, мы должны унаследоваться от какого-то существующего, базового  образа.  
В качестве базового образа будем использовать Ubuntu:18.04  
`FROM ubuntu:18.04`  
2. Теперь зададим переменную 'TZ' с указанием часового пояса:  
`ENV TZ=Europe/Moscow`  
3. **update** для обновления базы данных, а также пакеты **tzdata** и **git** установим одной строкой, чтобы не плодить слои в создаваемом образе.  
`RUN apt-get update && apt-get install -y tzdata && apt-get install -y git` 
4. Пакет **tzdata** выполнит синхронизацию с мировым временем. Осталось скопировать значение нашей переменной (т.е. часовой пояс) из каталога /usr/share/zoneinfo/ в символическую ссылку /etc/localtime, и с помощью стандартного потока ввода/вывода добавим это же значение в /etc/timezone.  
`RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone`   
5. Текст "Hello, IAC" на стандартное устройство вывода напечатем с помощью команды 'echo'.  
`CMD echo "Hello, IAC"`  
Когда мы запустим контейнер, то увидим данный текст.  
6. После написания Dockerfile соберем образ командой:  
`docker build .`  
7. Когда образ будет готов, запустим его командой:  
`docker run -ti <name_image> bash`  
8. После чего мы провалимся в контейнер, где можно будет проверить дату и установку git.  
`date`  
`git --version`  
.  
![](https://github.com/remizovk/test_iac/blob/2b30c517846514ff3bf6f098c4747b748f0a4eff/Screenshot%20from%202022-09-05%2015-38-33.png)
