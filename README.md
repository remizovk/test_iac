## Задание  
1. Написать docker-файл для контейнера, который выводит в поток стандартного вывода "Hello, IAC".  
- В качестве базового образа использовать Ubuntu 18.  
- Установить временную зону Europe/Moscow внутри контейнера.  
- Установить git внутри контейнера.  

2. Выложить Dockerfile в публичный репозиторий на gitlab.com.  
- README.md указать команду для запуска контейнера. Так же добавить в репозиторий скриншот выполненной команды.  

## Пишем Dockerfile 
1. Чтобы собрать свой образ, мы должны унаследоваться от какого-то существующего, базового  образа.  
В качестве базового образа будем использовать Ubuntu 18.04.  
В текстовом редакторе 'Vi' первой строкой напишем:  
> FROM ubuntu:18.04  
2. Следующей строкой зададим переменную 'TZ', где в качестве значения укажем часовой пояс:  
> ENV TZ=Europe/Moscow  
3. **update** для обновления базы данных, а также пакеты **tzdata** и **git** установим одной строкой, чтобы не плодить слои в создаваемом образе.  
`RUN apt-get update && apt-get install -y tzdata && apt-get install -y git` 
4. Пакет **tzdata** выполнит синхронизацию с мировым временем. Осталось скопировать значение нашей переменной (т.е. часовой пояс) из каталога /usr/share/zoneinfo/ в символическую ссылку /etc/localtime, и с помощью стандартного потока ввода/вывода добавим это же значение в /etc/timezone.  
`RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone`   
5. Текст "Hello, IAC" на стандартное устройство вывода напечатем с помощью команды 'echo'.  
`CMD echo "Hello, IAC"`  
6. Dockerfile готов. Соберем образ командой:  
`docker build .`  
7. Когда образ будет готов, проверим результаты:  
`docker run -ti <name_image>`  
В ответ выйдет текст: *Hello, IAC*  
8. Теперь проверим установку часового пояса и времени:    
`docker run -ti <name_image> date`  
В ответ получим московское время.  
9. Проверим установку git:  
`docker run -ti <name_image> git --version`  
В ответ увидим версию Git.  


![](https://github.com/remizovk/test_iac/blob/ee2b3e63874bb27f0654bf8e10528351a7294337/Screenshot%20from%202022-09-07%2013-08-19.png)
