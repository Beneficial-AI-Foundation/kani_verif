FROM debian:bookworm-slim

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    pkg-config \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Install the latest stable Rust toolchain
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"
RUN rustup default stable && rustup update

# Prepend /usr/local/bin to PATH to prioritize our custom tools
ENV PATH="/usr/local/bin:${PATH}"

# Install Kani
RUN cargo install --locked kani-verifier

# Set up Kani (download solvers and backends)
RUN cargo kani setup

# Verify installations
RUN cargo --version && kani --version

# Set working directory to mounted volume location
WORKDIR /work

# Set default command to provide a shell with tools
CMD ["/bin/bash"]
