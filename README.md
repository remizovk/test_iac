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
`FROM ubuntu:18.04`  
2. Следующей строкой зададим переменную 'TZ', где в качестве значения укажем часовой пояс:  
`ENV TZ=Europe/Moscow`  
3. **update** для обновления базы данных, а также пакеты **tzdata** и **git** установим одной строкой, чтобы не плодить слои в создаваемом образе.  
`RUN apt-get update && apt-get install -y tzdata && apt-get install -y git`  
4. Для систем Linux обычно имеется два файла, связанных с конфигурацией информации о часовом поясе.  
\- */etc/localtime (это символическая ссылка на каталог /usr/share/zoneinfo)*  
\- */etc/timezone*  
Пакет **tzdata**, из предыдущей команды, выполнит синхронизацию с мировым временем. А нам нужно внести правки в /etc/localtime и /etc/timezone.  
Сначала удалим символическую ссылку /etc/localtime, чтобы потом ее пересоздать на каталог /usr/share/zoneinfo, в который мы тоже внесем изменения:  
`RUN rm -rf /etc/localtime`  
5. Теперь, используя переменную 'TZ', добавим часовой пояс в каталоге /usr/share/zoneinfo и создадим новую символическую ссылку на него. Также, с помощью переменной 'TZ' и команды echo, добавим часовой пояс в каталог /etc/timezone.  
`RUN ln -s /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone`  
6. Текст "Hello, IAC" на стандартное устройство вывода напечатем с помощью команды 'echo'.  
`CMD echo "Hello, IAC"`  
7. Dockerfile готов. Соберем образ командой:  
`docker build .`    
8. Когда образ будет готов, проверим результаты:  
`docker run <name_image>`    
В ответ выйдет текст: *Hello, IAC*  
9. Теперь проверим установку местного времени:    
`docker run <name_image> date`  
В ответ получим московское время.  
10. Далее проверим, что символическая ссылка /etc/localtime указывает на нужный каталог:  
`docker run <name_image> readlink /etc/localtime`  
Должен появиться каталог с нашим часовым поясом: */usr/share/zoneinfo/Europe/Moscow*  
11. Ну и наконец проверим установку git:  
`docker run <name_image> git --version`  
В ответ увидим версию Git.  


![](https://github.com/remizovk/test_iac/blob/206c69a5ab6a99246596204269aefa84f3b26c7c/Screenshot%20from%202022-09-07%2023-50-20.png)
