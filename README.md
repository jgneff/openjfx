## ![Duke, the Java mascot, waving](images/icon.png) OpenJFX Snap

This project builds a [Snap package](https://snapcraft.io) of OpenJFX directly from its [official repository](https://github.com/openjdk/jfx). OpenJFX is the open-source project that develops JavaFX.

The resulting package, together with OpenJDK 11 or later, provides everything you need to develop a JavaFX application on Linux, including all of the latest modular JARs, native libraries, JMOD archives, API documentation, and source code of JavaFX.

### Installation

Install the OpenJFX Snap package with the command:

```console
$ sudo snap install openjfx
```

To develop a JavaFX application, you'll also need the Java Development Kit (JDK). On Debian-based systems, such as Ubuntu, you can install the latest OpenJDK Long Term Support (LTS) release and its documentation with the command:

```console
$ sudo apt install default-jdk default-jdk-doc
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds no [interfaces](https://snapcraft.io/docs/supported-interfaces) to its permissions.

Its manifest file, `manifest.yaml`, lets you audit the build. The file's `build_url` key links to a page on Launchpad with more details, including the log from the [build machine](https://launchpad.net/builders) where it ran. The log file lets you verify that the package was built from source using only the software in [Ubuntu 18.04 LTS](https://cloud-images.ubuntu.com/bionic/current/) and the official [Gradle 6.3](https://gradle.org/releases/) release.

### Usage

The installed package includes the following directories:

* `/snap/openjfx/current/jmods` - JMOD archives for `jlink`
* `/snap/openjfx/current/sdk/api` - Javadoc API documentation
* `/snap/openjfx/current/sdk/lib` - Modular JARs and native libraries
* `/snap/openjfx/current/sdk/src` - Java source files

The JDK tools need to know two locations: the JavaFX library directory and the JMOD archives directory. The OpenJFX Snap package provides these locations with two environment variables, as described below.

The `openjfx` command prints the location of a file that defines the environment variables:

```console
$ openjfx
/snap/openjfx/x1/bin/openjfx.env
```

The file exports the `JAVAFX_LIB` and `JAVAFX_MOD` environment variables:

```console
$ cat $(openjfx)
# Source this file for OpenJFX environment variables
export JAVAFX_LIB=/snap/openjfx/current/sdk/lib
export JAVAFX_MOD=/snap/openjfx/current/jmods
```

To set the variables in your current shell, use the `source` or "dot" (`.`) command to read and execute the commands from the file:

```console
$ . $(openjfx)
```

You can then verify that `JAVAFX_LIB` and `JAVAFX_MOD` are defined with:

```console
$ printenv | grep JAVAFX
JAVAFX_LIB=/snap/openjfx/current/sdk/lib
JAVAFX_MOD=/snap/openjfx/current/jmods
```

Once defined, you can use these variables in arguments to the `java`, `javac`, `javadoc`, `jlink`, and `jpackage` tools of the JDK.

### Contributing

Ultimately, I would like to see the latest OpenJFX available from the package repositories of all Linux distributions. Then on Ubuntu 20.04 LTS, for example, you could install it with the command:

```console
$ sudo apt install openjfx-15
```

Until that time, this Snap package can be a temporary solution by providing the latest OpenJFX on as many Linux distributions and architectures as possible. I welcome your help and support.

### Building

On Linux systems, you can build the Snap package directly by installing [Snapcraft](https://snapcraft.io/snapcraft) on your development workstation. The bottom of the Snapcraft page shows how to enable Snaps for your Linux distribution.

Whether you're running Windows, macOS, or Linux, you can use [Multipass](https://multipass.run) to build this project in an Ubuntu virtual machine (VM). For example, the following command will launch the Multipass [primary instance](https://multipass.run/docs/primary-instance) with 2 CPUs, 4 GiB of RAM, and Ubuntu 20.10 (Groovy Gorilla):

```console
$ multipass launch --name primary --cpus 2 --mem 4G groovy
```

The `snap/snapcraft.yaml` files on the *candidate*, *beta*, and *edge* branches define the build of the Snap package. Run the following commands to install Snapcraft, clone this repository, switch to the *candidate* branch, and start building the package:

```console
$ sudo snap install snapcraft
$ git clone https://github.com/jgneff/openjfx.git
$ cd openjfx
$ git switch candidate
$ snapcraft
```

Snapcraft launches a new Multipass VM to ensure a clean and isolated build environment. The VM is named `snapcraft-openjfx` and runs Ubuntu 18.04 LTS (Bionic Beaver). The project's directory on the host system is mounted as `/root/project` in the guest VM, so any changes you make on the host are seen immediately in the guest, and vice versa.

**Note:** If you run the initial `snapcraft` command itself inside a VM, your system will need *nested VM* functionality. The [Build Options](https://snapcraft.io/docs/build-options) page lists alternatives, such as using an LXD container or running on a remote server using Launchpad.

If the build fails, you can run the command again with the `--debug` option to remain in the VM after the error:

```console
$ snapcraft -d
```

From within the VM, you can then clean the Snapcraft part and try again:

```console
# snapcraft clean jfx
Cleaning pull step (and all subsequent steps) for jfx
# snapcraft
  ...
BUILD SUCCESSFUL in 2m 7s
136 actionable tasks: 136 executed
  ...
Priming bin
Priming jfx
The 'jfx' part is missing libraries that are not included in the snap or base.
They can be satisfied by adding the following entry for this part
stage-packages:
  ...
Snapping...
Snapped openjfx_15.0.1+1_amd64.snap
```

When the build completes, you'll find the Snap package in the project's root directory, along with the log file if you ran the build remotely.

### License and Trademarks

This project is licensed under the GNU General Public License v2.0 with the Classpath exception, the same license used by Oracle for the OpenJFX project. See the files [LICENSE](LICENSE) and [ADDITIONAL_LICENSE_INFO](ADDITIONAL_LICENSE_INFO) for details.

Java, JavaFX, and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. See the file [TRADEMARK](TRADEMARK) for details.
