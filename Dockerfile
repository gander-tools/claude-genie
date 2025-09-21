FROM alpine:3.22

RUN addgroup -g 1000 claude && \
    adduser -u 1000 -G claude -s /bin/bash -D claude && \
    apk add --no-cache bash curl libstdc++ libgcc && \
    mkdir -p /home/claude/.claude /workspace && \
    echo {} > /home/claude/.claude.json && \
    chown -R claude:claude /home/claude/.claude /workspace /home/claude/.claude.json

USER claude

WORKDIR /workspace

RUN curl -fsSL https://claude.ai/install.sh | bash

CMD ["/home/claude/.local/bin/claude", "--dangerously-skip-permissions"]