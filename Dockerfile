FROM ubuntu:latest
RUN apt update -y
RUN apt install curl sudo git nano -y

RUN useradd -m -s /bin/bash test && \
    echo "test:test" | chpasswd && \
    usermod -aG sudo test

# Allow 'test' user to use sudo without password prompt
RUN echo "test ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the 'test' user and set the home directory as the working directory
USER test

WORKDIR /home/test

RUN git clone https://github.com/timosarkar/nix

RUN sudo curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
  --extra-conf "sandbox = false" \
  --init none \
  --no-confirm

ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

CMD ["bash"]
