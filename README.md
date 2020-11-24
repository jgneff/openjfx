## ![Duke, the Java mascot, waving](images/icon.png) OpenJFX Snap

This project builds a Snap package of OpenJFX directly from its [official repository](https://github.com/openjdk/jfx). The OpenJFX package, together with OpenJDK, provide all the libraries, JMOD files, API documentation, and source code that you need to develop a JavaFX application on Linux.

With two commands, you can install OpenJDK and OpenJFX and get automatic updates containing the latest features and bug fixes. For example, on Debian-based systems such as Ubuntu, just run:

```console
$ sudo apt install default-jdk
$ sudo snap install openjfx
```

The Snap package installs with *strict* [confinement](https://snapcraft.io/docs/snap-confinement) and defines no extra [interfaces](https://snapcraft.io/docs/supported-interfaces). The Snap manifest file `manifest.yaml` lets you audit the build, and its `build_url` key links to the log file from the Launchpad build machine. The build log lets you verify that the package was built from source using only Ubuntu 18.04 LTS and the official [Gradle 6.3](https://gradle.org/releases/) release.

### Programming with JavaFX

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

The content of the Snap package directories is listed below:

* `/snap/openjfx/current/jmods` - JMOD files for use with `jlink`
* `/snap/openjfx/current/sdk/doc` - Javadoc API documentation
* `/snap/openjfx/current/sdk/lib` - Modular JAR files and native libraries
* `/snap/openjfx/current/sdk/src` - Java source files

### Building the Snap

Whether you're running Windows, macOS, or Linux, you can use [Multipass](https://multipass.run) to build the project in an Ubuntu virtual machine (VM). For example, the following command will launch the Multipass [primary instance](https://multipass.run/docs/primary-instance) with 2 CPUs, 4 GiB of RAM, and Ubuntu 20.10 (Groovy Gorilla):

```console
$ multipass launch --name primary --cpus 2 --mem 4G groovy
```

The [snapcraft.yaml](snap/snapcraft.yaml) file defines the build of the Snap package. Run the following commands to install Snapcraft and start building the Snap package:

```console
$ sudo snap install snapcraft
$ snapcraft
```

Snapcraft launches a new Multipass VM to ensure a clean and isolated build environment. The VM is named `snapcraft-openjfx` and runs Ubuntu 18.04 LTS (Bionic Beaver). The project's directory on the host system is mounted as `/root/project` in the guest VM, so any changes you make on the host are seen immediately in the guest, and vice versa.

**Note:** If you run the initial `snapcraft` command itself inside a VM, your system will need *nested VM* functionality. See the [Build Options](https://snapcraft.io/docs/build-options) page for alternatives.

If the build fails, you can run the command again with the `--debug` option to remain in the VM after the error:

```console
$ snapcraft -d
```

From within the VM, you can then clean the Snapcraft build and try again:

```console
# snapcraft clean jfx
Cleaning pull step (and all subsequent steps) for jfx
Cleaning up staging area
Cleaning up parts directory
# snapcraft
```

The Snapcraft [Gradle plugin](https://snapcraft.io/docs/gradle-plugin) uses the OpenJFX [build.gradle](jfx/build.gradle) file, but it runs Gradle in the guest VM. The plugin runs Gradle with `./gradlew` as shown below:

```console
# snapcraft
  ...
Pulling jfx
Found gradlew, skipping gradle setup.
Building jfx
./gradlew -PJDK_DOCS=file:///usr/share/doc/openjdk-11-jre-headless/api/ \
  sdk jmods javadoc jar
Downloading https://services.gradle.org/distributions/gradle-6.3-bin.zip
  ...
BUILD SUCCESSFUL in 3m 57s
138 actionable tasks: 138 executed
Staging jfx
Priming jfx
  ...
Snapping
Snapped openjfx_16.0.0_amd64.snap
```

When the build completes, you'll find the Snap package in the project's root directory on the host.
