VERSION_PLAYWRIGHT=latest
VERSION_OPENCODE=1.3.9
VERSION_OPENCLAW=2026.3.28
JAVA_MAJOR_VERSION=17

#docker build -t fellow99/playwright-vnc:$VERSION_PLAYWRIGHT -f Dockerfile-playwright-vnc .
docker build -t fellow99/playwright-opencode:$VERSION_OPENCODE -f Dockerfile-playwright-opencode --build-arg VERSION_OPENCODE=$VERSION_OPENCODE .
docker build -t fellow99/playwright-opencode-java$JAVA_MAJOR_VERSION:$VERSION_OPENCODE -f Dockerfile-playwright-opencode-java --build-arg VERSION_OPENCODE=$VERSION_OPENCODE --build-arg JAVA_MAJOR_VERSION=$JAVA_MAJOR_VERSION .
docker build -t fellow99/playwright-opencode-openclaw:$VERSION_OPENCODE-$VERSION_OPENCLAW -f Dockerfile-playwright-opencode-openclaw --build-arg VERSION_OPENCODE=$VERSION_OPENCODE --build-arg VERSION_OPENCLAW=$VERSION_OPENCLAW .
docker build -t fellow99/playwright-opencode-openclaw-java$JAVA_MAJOR_VERSION:$VERSION_OPENCODE-$VERSION_OPENCLAW -f Dockerfile-playwright-opencode-openclaw-java --build-arg VERSION_OPENCODE=$VERSION_OPENCODE --build-arg VERSION_OPENCLAW=$VERSION_OPENCLAW --build-arg JAVA_MAJOR_VERSION=$JAVA_MAJOR_VERSION .

#docker save fellow99/playwright-vnc:$VERSION_PLAYWRIGHT > fellow99_playwright-vnc_$VERSION_PLAYWRIGHT.tar
#docker save fellow99/playwright-opencode:$VERSION_OPENCODE > fellow99_playwright-opencode_$VERSION_OPENCODE.tar
#docker save fellow99/playwright-opencode-java$JAVA_MAJOR_VERSION:$VERSION_OPENCODE > fellow99_playwright-opencode-java$JAVA_MAJOR_VERSION_$VERSION_OPENCODE.tar
docker save fellow99/playwright-opencode-openclaw-java$JAVA_MAJOR_VERSION:$VERSION_OPENCODE-$VERSION_OPENCLAW > fellow99_playwright-opencode-openclaw-java${JAVA_MAJOR_VERSION}_$VERSION_OPENCODE-$VERSION_OPENCLAW.tar

#gzip fellow99_playwright-vnc_$VERSION.tar
#gzip fellow99_playwright-opencode_$VERSION_OPENCODE.tar
#gzip fellow99_playwright-opencode-java$JAVA_MAJOR_VERSION_$VERSION_OPENCODE.tar
#gzip fellow99_playwright-opencode-openclaw-java${JAVA_MAJOR_VERSION}_$VERSION_OPENCODE-$VERSION_OPENCLAW.tar
