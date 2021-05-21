FROM ubuntu:20.04

## refs: https://luarocks.org/
## refs: https://luarocks.cn/

USER root

# Install lua depends
RUN apt-get update \ 
    && DEBIAN_FRONTEND=noninteractive apt-get install -y sudo nano make git luarocks libssl-dev \
	&& apt-get autoclean \
	&& apt-get clean \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

RUN git config --global user.name "wangyc@risetek.com" && git config --global user.email "wangyc@risetek.com" \
    && echo export LS_COLORS='$LS_COLORS':\''di=01;35':\' >> /root/.bashrc
       
RUN luarocks install luasocket --server https://luarocks.cn
RUN luarocks install luamqtt --server https://luarocks.cn
RUN luarocks install luabitop --server https://luarocks.cn
RUN luarocks install lua-protobuf --server https://luarocks.cn
RUN luarocks install serpent --server https://luarocks.cn

# for lua nats support
RUN luarocks install lua-cjson --server https://luarocks.cn
RUN luarocks install uuid --server https://luarocks.cn

## custom lua programs
RUN mkdir -p /luapath
WORKDIR /luapath
COPY daemon.lua .
COPY mqttc.lua .
COPY nats.lua .
COPY publish.lua .
COPY subscribe.lua .
COPY SessionStatus.pb .

COPY docker/docker-entrypoint.sh /entrypoint.sh

VOLUME  /workspace
WORKDIR /workspace

RUN lua -e "print ('hello LUA world')"

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]

