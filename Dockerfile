FROM ubuntu:20.04

ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update
RUN apt-get install -y --no-install-recommends tor tor-geoipdb torsocks
RUN apt-get install -y python3-pip 
RUN apt-get install -y psmisc netcat
RUN mkdir -p /scripts
WORKDIR /scripts
COPY ./requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN playwright install --with-deps chromium
RUN apt-get clean
ADD torrc /etc/tor/torrc
COPY ./entrypoint.sh /scripts/entrypoint.sh
COPY ./fetch.py /scripts/fetch.py
COPY ./refreship.py /scripts/refreship.py
RUN chmod +x entrypoint.sh
ENTRYPOINT ["sh","/scripts/entrypoint.sh"]
CMD ["bash"]
