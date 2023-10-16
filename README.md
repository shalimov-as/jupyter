# Проект Jupyter

Содержит образы с jupyter для быстрого тестирования проектов компьютерного зрения.
Включает в себя все необходимые пакеты python, используемые в ходе разработки

Нужен для быстрой проверки гипотез и визуализации данных на сервере разработчика

# Установка

Для работы требуется docker, nvidia-docker2. Протестирована работа для Docker версии 20.10.12.

Инструкция по установке [Docker engine](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)

Для работы nvidia-docker2 необходимо установить [Linux x64 display driver](https://www.nvidia.ru/Download/index.aspx?lang=ru) от Nvidia

Инструкция по установке [nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#setting-up-nvidia-container-toolkit)

# Структура каталогов

Для корректной работы, необходима следующая структура каталогов:
```
projects/ # проекты
    yolox/ # проект с YOLOX
        notebooks/ # jupyter ноутбуки проекта YOLOX
            train_yolox.ipynb
            val_yolox.ipynb
        ...
    jupyter/ # Проект Jupyter CV container
        run.sh
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
# Пример запуска

Для запуска, необходимо выполнить [run.sh](./run.sh)

Первым аргументом нужно передать название проекта из структуры каталогов.
Для YOLOX это yolox (можно использовать tab и использовать относительные пути до проекта):
```shell
./jupyter/run.sh yolox/
```

В консоли должна отобразиться ссылка вида `http://127.0.0.1:8888/?token=` для доступа к ноутбукам

Также её можно найти в логах контейнера `jupyter_yolox`:
```shell
docker logs jupyter_yolox
```

Пароль для доступа - `admin`
