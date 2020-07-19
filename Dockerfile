FROM python:3.6.4-stretch

WORKDIR /app

RUN apt-get -qq update && \
    apt-get -qq install ca-certificates gettext locales libsasl2-dev python-dev libpq-dev netcat && \
    rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
RUN ln -fs /usr/share/zoneinfo/CET /etc/localtime

COPY src/requirements.txt /app/requirements.txt
RUN pip install -U pip setuptools wheel && \
    pip install -r /app/requirements.txt

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]