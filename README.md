# adb-all

`adb-all` is a command-line tool that allows you to run `adb` commands on all connected Android devices at once. The command is executed in parallel on each device, and the output from each device is displayed separately.

## Usage

```bash
adb-all <command>
```

For example, you can run the following command to list all installed packages on all connected devices:

```bash
adb-all shell pm list packages
```

## Options

--help: Print a help message and exit.

## Installation

You can install `adb-all` via Homebrew:

```bash
brew tap nerandell/adb
brew install adb-all
```

Alternatively, you can install `adb-all` manually by cloning the repository and adding the `bin` directory to your `PATH`.

## License

`adb-all` is licensed under the MIT License. See the `LICENSE` file for more information.

