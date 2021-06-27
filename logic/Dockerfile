FROM emscripten/emsdk:2.0.17

RUN echo "## Start building" \
    && echo "## Update and install packages" \
    && apt-get -qq -y update \
    && apt-get -qq install -y --no-install-recommends \
        clang \
    && echo "## Done"

RUN curl -fsSL https://sh.rustup.rs | sh -s -- -y --profile minimal -t wasm32-unknown-emscripten --default-toolchain 1.53.0
ENV PATH=$PATH:$HOME/.cargo/bin

RUN bash -lc "cargo --version"