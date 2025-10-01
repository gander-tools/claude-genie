FROM alpine:3.22

RUN apk add --no-cache bash curl libstdc++ libgcc && \
    addgroup -g 1000 claude && \
    adduser -u 1000 -G claude -s /bin/bash -D claude

USER claude

ENV PATH="/home/claude/.local/bin:$PATH" SHELL="/bin/bash"

RUN curl -fsSL https://claude.ai/install.sh | bash

WORKDIR /workspace

CMD ["/home/claude/.local/bin/claude", "--dangerously-skip-permissions"]