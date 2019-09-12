FROM rust:1-stretch

RUN apt-get update && apt-get install -y \
    gdb \
    gdbserver \
    bash \
    && rm -rf /var/lib/apt/lists/*

