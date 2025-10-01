# Claude Genie

A Docker container for Claude development environment.

**Genie** - Like a genie in a bottle, Claude performs tasks as commanded while contained within the Docker environment.

## Quick Start

First, create a named volume for Claude configuration:

```bash
docker volume create project_claude_home
```

Then run the container:

```bash
docker run -it --rm \
  -v .:/workspace \
  -v project_claude_home:/home/claude \
  ghcr.io/gander-tools/claude-genie:latest
```

## Volume Mounts

- `.:/workspace` - Your current directory as project workspace
- `project_claude_home:/home/claude` - Named volume for Claude home directory (recommended for persistence)

### What's in /home/claude?

The `/home/claude` directory contains:
- `.claude.json` - Claude CLI configuration (API keys, preferences)
- `.claude/` - Claude state and session data
- `.local/bin/` - Claude CLI binaries and wrapper scripts
- `.bash_history` - Command history

**Why preserve it?** Mounting this directory ensures your Claude configuration, authentication, and command history persist across container restarts.

## Notes

Claude is run with `--dangerously-skip-permissions` flag by default in this container. This means:
- Claude bypasses standard file permission checks
- Can edit/delete any files in mounted volumes without warnings
- File operations execute immediately without additional prompts

This is useful in Docker containers where file access is already restricted to mounted volumes and user permissions are mapped via `--user $(id -u):$(id -g)`.

## License

MIT License - see [LICENSE](LICENSE) file for details.
