# paranoid-ollama
Run ollama inside Docker container fully local forbidding it to establish any outgoing connections for security reasons

## How to use

### Install

```bash
git clone https://github.com/bellerofonte/paranoid-ollama.git .
docker compose build --no-cache
```

### Run
```bash
docker compose up -d
```

### Access Ollama
```bash
curl http://localhost:11434/api/generate -d '{"model": "codellama:13b-code", "prompt": "Hello, world!"}'
```