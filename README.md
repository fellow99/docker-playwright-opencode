# docker-playwright-opencode
创建了一个基于 Playwright 和 Opencode 的 Docker 镜像。
 - 包含Chromium的最新版本
 - 提供Playwright MCP的服务环境
 - 提供Opencode的服务环境
 - 提供OpenClaw的服务环境（可选）
 - 提供Python环境、Node.js环境、Bun环境
 - 提供Java环境（可选）

## 使用方法
1. 克隆仓库
```bash
git clone https://github.com/fellow99/docker-playwright-opencode.git
cd docker-playwright-opencode
```

2. 一键构建、导出、打包镜像
```bash
./build.sh
```

3. 逐步构建
```bash
VERSION_PLAYWRIGHT=latest
VERSION_OPENCODE=1.3.9
VERSION_OPENCLAW=2026.3.28
JAVA_MAJOR_VERSION=17

docker build -t fellow99/playwright-vnc:$VERSION_PLAYWRIGHT -f Dockerfile-playwright-vnc .

docker build -t fellow99/playwright-opencode:$VERSION_OPENCODE -f Dockerfile-playwright-opencode --build-arg VERSION_OPENCODE=$VERSION_OPENCODE .

docker build -t fellow99/playwright-opencode-java$JAVA_MAJOR_VERSION:$VERSION_OPENCODE -f Dockerfile-playwright-opencode-java --build-arg VERSION_OPENCODE=$VERSION_OPENCODE --build-arg JAVA_MAJOR_VERSION=$JAVA_MAJOR_VERSION .

docker build -t fellow99/playwright-opencode-openclaw:$VERSION_OPENCODE-$VERSION_OPENCLAW -f Dockerfile-playwright-opencode-openclaw --build-arg VERSION_OPENCODE=$VERSION_OPENCODE --build-arg VERSION_OPENCLAW=$VERSION_OPENCLAW .

docker build -t fellow99/playwright-opencode-openclaw-java$JAVA_MAJOR_VERSION:$VERSION_OPENCODE-$VERSION_OPENCLAW -f Dockerfile-playwright-opencode-openclaw-java --build-arg VERSION_OPENCODE=$VERSION_OPENCODE --build-arg VERSION_OPENCLAW=$VERSION_OPENCLAW --build-arg JAVA_MAJOR_VERSION=$JAVA_MAJOR_VERSION .
```

## 运行容器
- 建议把各种配置文件、数据目录放在宿主机，再通过 `-v` 参数挂载到容器。

### playwright + opencode
```bash
docker run -d --name playwright-opencode fellow99/playwright-opencode:1.3.9 \
    -v /path/to/your/opencode.json:/root/.config/opencode/opencode.json \
    -v /path/to/your/oh-my-opencode.json:/root/.config/opencode/oh-my-opencode.json \
    -v /path/to/your/.local_share_opencode:/root/.local/share/opencode \
    -v /path/to/your/workspace:/root/workspace \
    -v /path/to/your/user-data:/root/user-data \
    -v /path/to/your/.agents:/root/.agents \
    -p 4096:4096 \
    -p 8931:8931 \
    -p 6080:6080 \
    -p 8000:8000 \
    -p 5173:5173 \
    -p 3000:3000
```

### playwright + opencode + openclaw + java17
```bash
docker run -d --name playwright-opencode-openclaw-java17 fellow99/playwright-opencode-openclaw-java17:1.3.9-2026.3.28 \
    -v /path/to/your/opencode.json:/root/.config/opencode/opencode.json \
    -v /path/to/your/oh-my-opencode.json:/root/.config/opencode/oh-my-opencode.json \
    -v /path/to/your/.local_share_opencode:/root/.local/share/opencode \
    -v /path/to/your/workspace:/root/workspace \
    -v /path/to/your/user-data:/root/user-data \
    -v /path/to/your/.agents:/root/.agents \
    -v /path/to/your/.mcporter:/root/.mcporter
    -v /path/to/your/.m2:/root/.m2 \
    -v /path/to/your/.gradle:/root/.gradle \
    -p 18789:18789 \
    -p 18790:18790 \
    -p 4096:4096 \
    -p 8931:8931 \
    -p 6080:6080 \
    -p 8000:8000 \
    -p 5173:5173 \
    -p 3000:3000
```

### docker-compose
docker-compose.yml（示例）：
```yaml
services:
  openclaw-all:
    container_name: openclaw-all
    image: fellow99/playwright-opencode-openclaw-java21:1.3.8-2026.3.28
    restart: unless-stopped
    cap_add:
      - CHOWN
      - SETUID
      - SETGID
      - DAC_OVERRIDE
    env_file: .env
    volumes:
      - ./playwright-opencode-openclaw.pm2.json:/root/playwright-opencode-openclaw.pm2.json
      - ./.openclaw:/root/.openclaw
      - ./.opencode/opencode.json:/root/.config/opencode/opencode.json
      - ./.opencode/oh-my-opencode.json:/root/.config/opencode/oh-my-opencode.json
      - ./.local_share_opencode:/root/.local/share/opencode
      - ./.mcporter:/root/.mcporter
      - ./workspace:/root/workspace
      - ./user-data:/root/user-data
      - ./.agents:/root/.agents
      - ./.m2:/root/.m2
      - ./.gradle:/root/.gradle
    ports:
      - 18789:18789
      - 18790:18790
      - 4096:4096
      - 8931:8931
      - 6080:6080
      - 5173:5173
      - 8080:8080
      - 8000:8000
      - 3000:3000
    extra_hosts:
      - "host.docker.internal:host-gateway"
```

```bash
docker-compose -f docker-compose.yml up -d
```