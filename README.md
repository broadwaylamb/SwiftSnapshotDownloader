# SwiftSnapshotDownloader
A simple command line tool that fetches the latest development snapshot of the Swift language and installs it on your Mac.

## Installation
You can download a binary from [here](https://github.com/broadwaylamb/SwiftSnapshotDownloader/releases), or you can build the tool
from source. Like this:
```
$ git clone https://github.com/broadwaylamb/SwiftSnapshotDownloader.git
$ cd SwiftSnapshotDownloader
$ swift build -c release -Xswiftc -static-stdlib
$ cd .build/release
$ cp -f SwiftSnapshotDownloader /usr/local/bin/ssd
```

## What does it do?
The tool parses [swift.org](https://swift.org), finds the latest dev snapshot and downloads it to the current directory, then installs it (you may need the root access) and deletes the downloaded file.

If you run the tool with the `--keep-downloaded-file` option, the downloaded file will not be deleted after installation.

If at the moment of launching the tool a file with the same name as the lastest dev shapshot is present, no downloading will be performed, but that file will be used to install the new toolchain.
