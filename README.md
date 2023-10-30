# Проект Jupyter

Содержит образы с jupyter для быстрого тестирования проектов компьютерного зрения.
Включает в себя все необходимые пакеты python, используемые в ходе разработки

Нужен для быстрой проверки гипотез и визуализации данных на сервере разработчика

**Пароль для доступа в jupyter - `admin`**

# Установка (Linux)

Для работы требуется docker, nvidia-docker2. Протестирована работа для Docker версии 20.10.12.

Инструкция по установке [Docker engine](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

Для работы nvidia-docker2 необходимо установить [Linux x64 display driver](https://www.nvidia.ru/Download/index.aspx?lang=ru) от Nvidia

Инструкция по установке [nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#setting-up-nvidia-container-toolkit)

# Установка (Windows)

- Перейдите на [официальную страницу Docker](https://www.docker.com/products/docker-desktop) и скачайте установщик Docker Desktop для Windows.
- Запустите установщик и следуйте инструкциям на экране.
- Для возможности работать с видеокартой, необходимо использовать WSL. [Подробнее про установку](https://www.youtube.com/watch?v=YozfiLI1ogY)
- После установки запустите Docker Desktop через меню "Пуск".

# Структура каталогов

Для корректной работы, необходима следующая структура каталогов:
```
projects/ # проекты
    project_1/ # проект
        notebooks/ # jupyter ноутбуки проекта project_1
            train_project_1.ipynb
            val_project_1.ipynb
        ...
    jupyter/ # Проект Jupyter
        run.sh
        run.ps1
    ...
```
## Область видимости 

При работе с ноутбуками, будут доступны все файлы проекта, для которого запущен jupyter

Для доступа к другим каталогам, необходимо вручную монтировать volumes в [run.sh](./run.sh)

# Загрузка образа

Сейчас используется один образ `ghcr.io/shalimov-as/jupyter:gpu-python3.10-tf2.13.0`

Загрузка на машину разработчика
```shell
docker pull ghcr.io/shalimov-as/jupyter:gpu-python3.10-tf2.13.0
```
# Пример запуска (Linux)

Для запуска, необходимо выполнить [run.sh](./run.sh)

Первым аргументом нужно передать название проекта из структуры каталогов.
Для YOLOX это yolox (можно использовать tab и использовать относительные пути до проекта):
```shell
./jupyter/run.sh project_1/
```

В консоли должна отобразиться ссылка вида `http://127.0.0.1:8888/?token=` для доступа к ноутбукам

Также её можно найти в логах контейнера `jupyter_project_1`:
```shell
docker logs jupyter_project_1
```

# Пример запуска (Windows)

Для запуска, необходимо выполнить [run.ps1](./run.ps1)

Первым аргументом нужно передать название проекта из структуры каталогов.
Для YOLOX это yolox (можно использовать tab и использовать относительные пути до проекта):
```shell
.\jupyter\run.ps1 .\project_1\
```

В Docker Desktop для запущенного контейнера, во вкладке logs  должна отобразиться ссылка вида `http://127.0.0.1:8888/?token=` для доступа к ноутбукам.

Пароль для доступа в jupyter - `admin`
