#dockerfile #cli #ci-cd #container #binary-image #os #file-system #binary-image 

# Docker buildx build
## Purpose
- Build an image <mark style="background: #e4e62d;">from the specified dockerfile</mark>.
- Identical to [Docker image build](Docker%20image%20commands.md#Docker%20image%20build)
## Syntax
```bash
docker buildx build [OPTIONS] <Dockerfile-path> <target-path>
```
- `<target-path>` is usually `.` for current path.
## Options
### Specify dockerfile
- `-f` or `--file`: Specify the directory of dockerfile.
### Give image a tag
- `-t` or `--tag`: Specify an image tag.
- 
