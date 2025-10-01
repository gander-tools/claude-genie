# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Claude Genie is a Docker container that provides a pre-configured Claude development environment. The container includes Claude CLI with the `--dangerously-skip-permissions` flag enabled by default, allowing unrestricted file operations within mounted volumes.

## Architecture

- **Base Image**: Alpine Linux 3.22 (lightweight)
- **User Setup**: Non-root `claude` user (UID 1000, GID 1000) for security
- **Claude Installation**: Installed via official install script to `/home/claude/.local/bin/`
- **Entry Point**: Custom wrapper script `claude-genie` that invokes Claude with `--dangerously-skip-permissions`
- **Working Directory**: `/workspace` (where user projects are mounted)

## Build and Publish

Build the Docker image:
```bash
docker build -t ghcr.io/gander-tools/claude-genie:latest .
```

The GitHub Actions workflow (`.github/workflows/docker-publish.yml`) automatically builds and publishes the image to GitHub Container Registry on:
- Pushes to `main` branch (tagged as `latest`)
- Version tags matching `v*` pattern (tagged with semver)

## Running the Container

Standard run command with volume mounts:
```bash
docker run -it --rm \
  -v ./project/workspace:/workspace \
  -v ./project/config/.claude.json:/home/claude/.claude.json \
  -v ./project/config/.claude:/home/claude/.claude \
  --user $(id -u):$(id -g) \
  ghcr.io/gander-tools/claude-genie:latest
```

## Volume Mounts

- `/workspace` - Project workspace (required)
- `/home/claude/.claude.json` - Claude config file (optional)
- `/home/claude/.claude` - Claude config directory (optional)
- `/home/claude/` - Persistent home directory via named volume (when using devcontainer)

## Development Container

The `.devcontainer/devcontainer.json` configuration allows using this image as a VS Code dev container:
- Uses published image from GHCR
- Mounts named volume for persistent Claude home directory
- Container named after workspace folder for easy identification

## Communication Guidelines

- **Language**: Use English only in all code, comments, documentation, and commit messages
- **Developer interaction**: Check `CLAUDE.local.md` file for developer's preferred language and communicate accordingly
- **Code changes**: Make incremental changes - modify code in small steps, not all at once
