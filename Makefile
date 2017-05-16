build:
	swift build -c release -Xswiftc -static-stdlib

install:
	cp -f .build/release/SwiftSnapshotDownloader /usr/local/bin/ssd

clean:
	rm -rf .build/release/