FROM alpine:latest
LABEL maintainer "Cheewai Lai <cheewai.lai@gmail.com>"

ARG SUEXEC_VERSION=0.2

RUN apk add --no-cache python3 libacl libcrypto1.0 openssh-client \
 && apk add --no-cache --virtual=build-dependencies wget ca-certificates build-base acl-dev python3-dev openssl-dev \
 && wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python3 \
 && pip3 install attic \
 && apk add --update curl $buildDeps \
 && wget -O- https://github.com/ncopa/su-exec/archive/v${SUEXEC_VERSION}.tar.gz | tar zxvf - \
 && cd su-exec-${SUEXEC_VERSION} \
 && make \
 && mv su-exec /usr/bin \
 && cd .. && rm -rf su-exec-${SUEXEC_VERSION} \
 && chmod +x /usr/bin/su-exec \
 && apk del build-dependencies

#VOLUME /root/.attic
#VOLUME /root/.cache/attic

ADD docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
