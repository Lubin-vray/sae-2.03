FROM kalilinux/kali-rolling

RUN apt update -y && apt install openssh-server -y
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
RUN useradd --create-home --gid root kali
RUN echo "kali\nkali" | (passwd kali)
RUN apt update -y && apt install wget -y
RUN apt update -y && apt install iputils-ping -y
RUN apt update -y && apt install slowhttptest -y

EXPOSE 22

CMD service ssh start && /bin/bash