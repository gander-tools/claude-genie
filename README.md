# Claude Genie

A Docker container for Claude development environment.

**Genie** - Like a genie in a bottle, Claude performs tasks as commanded while contained within the Docker environment.

## Quick Start

Run the container with the following command:

```bash
docker run -it --rm \
  -v ./project/workspace:/workspace \
  -v ./project/config/.claude.json:/home/claude/.claude.json \
  -v ./project/config/.claude:/home/claude/.claude \
  --user $(id -u):$(id -g) \
  ghcr.io/gander-tools/claude-genie:latest
```

## Volume Mounts

- `./project/workspace:/workspace` - Your project workspace directory
- `./project/config/.claude.json:/home/claude/.claude.json` - Claude configuration file
- `./project/config/.claude:/home/claude/.claude` - Claude configuration directory

## Notes

Claude is run with `--dangerously-skip-permissions` flag by default in this container. This means:
- Claude bypasses standard file permission checks
- Can edit/delete any files in mounted volumes without warnings
- File operations execute immediately without additional prompts

This is useful in Docker containers where file access is already restricted to mounted volumes and user permissions are mapped via `--user $(id -u):$(id -g)`.

## License

MIT License - see [LICENSE](LICENSE) file for details.
