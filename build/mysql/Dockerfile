FROM mysql:5.7.28

# COPY build/mysql/conf.d/my.cnf /etc/mysql/conf.d

RUN echo "[mysqld]" > /etc/mysql/conf.d/my.cnf
RUN echo "character-set-server=utf8" > /etc/mysql/conf.d/my.cnf
RUN echo "[mysql]" > /etc/mysql/conf.d/my.cnf
RUN echo "default-character-set=cp932" > /etc/mysql/conf.d/my.cnf
