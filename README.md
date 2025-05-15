# h-at-home-docker

Docker Image for e-h's H@H

## Tags

- `1.6.4`, `1.6`, `1`, `latest`: H@H version 1.6.4
- `1.6.3`: H@H version 1.6.3

## Setup

To make sure that data persists, a volume or bind mount should be used for the `/app/data` directory.

Example:

```bash
docker run -it \
  --name h-at-home \
  -p 443:443 \
  -v /path/to/data:/app/data \
  ghcr.io/pythoncoderas/h-at-home-docker
```

If you are using a port other than 443, change both sides of the `-p` flag accordingly. For example, if you want to use port 8080, you would do:

```bash
docker run -it \
  --name h-at-home \
  -p 8080:8080 \
  -v /path/to/data:/app/data \
  ghcr.io/pythoncoderas/h-at-home-docker
```

If you want to run the container in the background (non-interactive), you can either run it in the interactive mode once (to login) and then use `-d` instead of `-it` in the subsequent runs, or you can pre-make the login file. In order to do that:

```bash
mkdir -p /path/to/data/data
printf "%s" "<client id>-<client key>" > /path/to/data/data/client_login
```

If your client ID is `12345` and the client key is `12345678901234567890`, the content of the `client_login` file should be:

```plaintext
12345-12345678901234567890
```

Note: Make sure there is no newline!

Docker compose (assuming you made the login file as above):

```yaml
version: '3'
services:
  h-at-home:
    image: ghcr.io/pythoncoderas/h-at-home-docker
    container_name: h-at-home
    ports:
      - "443:443"
    restart: unless-stopped
    volumes:
      - /path/to/data:/app/data
```
