FROM rust:stretch

RUN apt-get update && apt-get install -y \
    gdb \
    gdbserver \
    && rm -rf /var/lib/apt/lists/*

