DETA_VERSION = v1.3.3-beta
LINUX_PLATFORM = x86_64-linux
LINUX_ARM_PLATFORM= arm64-linux
MAC_PLATFORM = x86_64-darwin
MAC_ARM_PLATFORM = arm64-darwin
WINDOWS_PLATFORM = x86_64-windows
ANDROID_ARM_PLATFORM= arm64-android

GATEWAY_DOMAIN = deta.dev
VISOR_URL = https://visor.deta.dev
LOGIN_URL = https://web.deta.sh/cli

LDFLAGS := -X github.com/deta/deta-cli/cmd.detaVersion=$(DETA_VERSION) $(LDFLAGS)
LDFLAGS := -X github.com/deta/deta-cli/cmd.gatewayDomain=$(GATEWAY_DOMAIN) $(LDFLAGS)
LDFLAGS := -X github.com/deta/deta-cli/cmd.visorURL=$(VISOR_URL) $(LDFLAGS)
LDFLAGS := -X github.com/deta/deta-cli/auth.loginURL=$(LOGIN_URL) $(LDFLAGS)
LDFLAGS := -X github.com/deta/deta-cli/auth.cognitoClientID=$(COGNITO_CLIENT_ID) $(LDFLAGS)
LDFLAGS := -X github.com/deta/deta-cli/auth.cognitoRegion=$(COGNITO_REGION) $(LDFLAGS)
LDFLAGS := -X github.com/deta/deta-cli/auth.detaSignVersion=$(DETA_SIGN_VERSION) $(LDFLAGS)
LDFLAGS := -X github.com/deta/deta-cli/api.version=$(DETA_VERSION) $(LDFLAGS)

.PHONY: build clean



build-linux:
	GOOS=linux GOARCH=amd64 go build -ldflags="$(LDFLAGS) -X github.com/deta/deta-cli/cmd.platform=$(LINUX_PLATFORM)" -o build/deta	
	cd build && zip -FSr deta-$(LINUX_PLATFORM).zip deta

build-linux-arm:
	GOOS=linux GOARCH=arm64 go build -ldflags="$(LDFLAGS) -X github.com/deta/deta-cli/cmd.platform=$(LINUX_ARM_PLATFORM)" -o build/deta	
	cd build && zip -FSr deta-$(LINUX_ARM_PLATFORM).zip deta

build-win:
	GOOS=windows GOARCH=amd64 go build -ldflags="$(LDFLAGS) -X github.com/deta/deta-cli/cmd.platform=$(WINDOWS_PLATFORM)" -o build/deta.exe	
	cd build && zip -FSr deta-$(WINDOWS_PLATFORM).zip deta.exe

build-mac:
	GOOS=darwin GOARCH=amd64 go build -ldflags="$(LDFLAGS) -X github.com/deta/deta-cli/cmd.platform=$(MAC_PLATFORM)" -o build/deta	
	cd build && zip -FSr deta-$(MAC_PLATFORM).zip deta

build-mac-arm:
	CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 go build -ldflags="$(LDFLAGS) -X github.com/deta/deta-cli/cmd.platform=$(MAC_ARM_PLATFORM)" -o build/deta	
	cd build && zip -FSr deta-$(MAC_ARM_PLATFORM).zip deta

build-android-arm:
	GOOS=android GOARCH=arm64 go build -ldflags="$(LDFLAGS) -X github.com/deta/deta-cli/cmd.platform=$(ANDROID_ARM_PLATFORM)" -o build/deta	
	cd build && zip -FSr deta-$(ANDROID_ARM_PLATFORM).zip deta

build: build-linux build-win build-mac build-mac-arm build-linux-arm build-android-arm

clean:
	rm -rf build
