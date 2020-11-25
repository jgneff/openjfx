## ![Duke, the Java mascot, waving](images/icon.png) OpenJFX Snap

This project builds a [Snap package](https://snapcraft.io) of OpenJFX directly from its [official repository](https://github.com/openjdk/jfx). The resulting package, together with OpenJDK, provides all you need to develop a JavaFX application on Linux — all the modular JARs, native libraries, JMOD archives, API documentation, and source code of JavaFX.

### Installation

With just two commands, you can install OpenJDK and OpenJFX and get automatic updates of the latest features and bug fixes. For example, on Debian-based systems such as Ubuntu, simply run:

```console
$ sudo apt install default-jdk libopenjfx-jni
$ sudo snap install openjfx
```

The first command installs your system's default Java Development Kit (JDK) and the packages required by the JavaFX native libraries. The second command installs the latest JavaFX.

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement), with no extra [permissions](https://snapcraft.io/docs/permission-requests). Its manifest file, `manifest.yaml`, lets you audit the build. The file's `build_url` key links to a page on Launchpad with more details, including the log from the [build machine](https://launchpad.net/builders) where it ran. The log file lets you verify that the package was built from source using only [Ubuntu 18.04 LTS](https://cloud-images.ubuntu.com/bionic/current/) and the official [Gradle 6.3](https://gradle.org/releases/) release.

### Usage

To compile, run, debug, and package your JavaFX application, the JDK tools need to know two locations: the directory of the JavaFX libraries, and the directory of the JavaFX JMOD files. The OpenJFX Snap package provides these locations as two environment variables. To see their values, run the `openjfx` command:

```console
$ openjfx
export JAVAFX_LIB=/snap/openjfx/x1/sdk/lib
export JAVAFX_MOD=/snap/openjfx/x1/jmods
```

To export the environment variables in your current shell, run the Bash `eval` command on the output of the `openjfx` command:

```console
$ eval $(openjfx)
```

You can then verify that the two variables are defined with:

```console
$ printenv | grep JAVAFX
JAVAFX_LIB=/snap/openjfx/x1/sdk/lib
JAVAFX_MOD=/snap/openjfx/x1/jmods
```

Once defined, you can use these variables in the arguments to the `java`, `javac`, `javadoc`, `jlink`, and `jpackage` tools of the JDK.

The Snap package includes the following directories:

* `/snap/openjfx/current/jmods` - JMOD files for `jlink`
* `/snap/openjfx/current/sdk/api` - API documentation
* `/snap/openjfx/current/sdk/lib` - Modular JAR files and native libraries
* `/snap/openjfx/current/sdk/src` - Java source files

### Contributing

Ultimately, I would like to see a package of the latest JavaFX for desktop systems and embedded platforms available on all Linux distributions. Then the two commands at this top of this page could be replaced by just one that installs both Java and JavaFX from your distribution's package repositories:

```console
$ sudo apt install default-jdk openjfx
```

That goal, if possible, will take some time. Meanwhile, this Snap package can provide a temporary solution by building all of JavaFX for at least those architectures where OpenJDK is available:

| Package   | amd64 | arm64 | armhf | ppc64el | s390x | Release |
| --------- |:-----:|:-----:|:-----:|:-------:|:-----:|:------- |
| Debian    | ❌ | ❌ | ❌ | ❌ | ❌ | Only JavaFX 11 desktop |
| Fedora    | ❌ | ❌ | ❌ | ❌ | ❌ | Only JavaFX 11 desktop |
| Snap now  | ✔️ | ❌ | ❌ | ❌ | ❌ | Latest JavaFX desktop |
| Snap goal | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | Latest JavaFX desktop + embedded |

If you share in this goal, I welcome your help and support.

### Building

Whether you're running Windows, macOS, or Linux, you can use [Multipass](https://multipass.run) to build the project in an Ubuntu virtual machine (VM). For example, the following command will launch the Multipass [primary instance](https://multipass.run/docs/primary-instance) with 2 CPUs, 4 GiB of RAM, and Ubuntu 20.10 (Groovy Gorilla):

```console
$ multipass launch --name primary --cpus 2 --mem 4G groovy
```

The [snapcraft.yaml](snap/snapcraft.yaml) file defines the build of the Snap package. Run the following commands to install Snapcraft and start building the package:

```console
$ sudo snap install snapcraft
$ snapcraft
```

Snapcraft launches a new Multipass VM to ensure a clean and isolated build environment. The VM is named `snapcraft-openjfx` and runs Ubuntu 18.04 LTS (Bionic Beaver). The project's directory on the host system is mounted as `/root/project` in the guest VM, so any changes you make on the host are seen immediately in the guest, and vice versa.

**Note:** If you run the initial `snapcraft` command itself inside a VM, your system will need *nested VM* functionality. In that case, see the [Build Options](https://snapcraft.io/docs/build-options) for alternatives, such as using an LXD container or running on a remote server using Launchpad.

If the build fails, you can run the command again with the `--debug` option to remain in the VM after the error:

```console
$ snapcraft -d
```

From within the VM, you can then clean the Snapcraft part and try again:

```console
# snapcraft clean jfx
Cleaning pull step (and all subsequent steps) for jfx
Cleaning up staging area
Cleaning up parts directory
# snapcraft
```

The Snapcraft [Gradle plugin](https://snapcraft.io/docs/gradle-plugin) uses the OpenJFX [build file](https://github.com/openjdk/jfx/blob/master/build.gradle), but it runs Gradle in the guest VM with the `./gradlew` command shown below:

```console
# snapcraft
  ...
Found gradlew, skipping gradle setup.
Building app
Building jfx
./gradlew -PJDK_DOCS=file:///usr/share/doc/openjdk-11-jre-headless/api/ \
  sdk jmods javadoc jar
Downloading https://services.gradle.org/distributions/gradle-6.3-bin.zip
  ...
BUILD SUCCESSFUL in 4m 0s
138 actionable tasks: 138 executed
Staging app
Staging jfx
Priming app
Priming jfx
  ...
Snapping
Snapped openjfx_16.0.0_amd64.snap
```

When the build completes, you'll find the Snap package in the project's root directory, along with the log file if you ran the build remotely.

### License

This project is licensed under the GNU General Public License v2.0 with the Classpath exception — the same license used by Oracle for the OpenJFX project. The license makes it possible for this project to be included eventually in the upstream project.
