![OpenJFX: Verifiable builds for Linux from source](images/banner.svg)

OpenJFX is the open-source project that develops JavaFX. This project builds [Snap packages](https://snapcraft.io/openjfx) of OpenJFX directly from its [source repository](https://github.com/openjdk/jfx). These packages, together with OpenJDK 11 or later, provide everything you need to develop a JavaFX application on Linux, including all of the latest JAR files, native libraries, JMOD archives, API documentation, and source code of JavaFX.

**Note:** this repository uses branches differently from most repositories on GitHub. It follows the workflow recommended by Junio Hamano, the core maintainer of Git, for managing [permanent parallel branches](https://www.spinics.net/linux/lists/git/msg94767.html). The `snapcraft.yaml` build files are found only on the *candidate*, *beta*, and *edge* branches, named after the Snap channels where the builds are published. The files common to all branches are updated only on the *main* branch. Merges are done from the *main* branch to the three channel branches, never the other way.

The list below links directly to each of the [Snapcraft build files](https://snapcraft.io/docs/snapcraft-yaml-reference):

* [`snap/snapcraft.yaml`](https://github.com/jgneff/openjfx/blob/candidate/snap/snapcraft.yaml) at candidate
* [`snap/snapcraft.yaml`](https://github.com/jgneff/openjfx/blob/beta/snap/snapcraft.yaml) at beta
* [`snap/snapcraft.yaml`](https://github.com/jgneff/openjfx/blob/edge/snap/snapcraft.yaml) at edge

## Install

Install the OpenJFX Snap package with the command:

```console
$ sudo snap install openjfx
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds no [interfaces](https://snapcraft.io/docs/supported-interfaces) to its permissions.

You'll also need the Java Development Kit (JDK). On Debian-based systems, such as Ubuntu, you can install the latest OpenJDK Long Term Support (LTS) release and documentation with the command:

```console
$ sudo apt install default-jdk default-jdk-doc
```

On Fedora-based systems, you can install the latest OpenJDK release and documentation with the commands:

```console
$ sudo dnf install java-latest-openjdk-devel
$ sudo dnf install java-latest-openjdk-jmods
$ sudo dnf install java-latest-openjdk-javadoc
```

Install the OpenJFX Snap package from a channel other than the *stable* channel with one of the following commands:

```console
$ sudo snap install openjfx --candidate
$ sudo snap install openjfx --beta
$ sudo snap install openjfx --edge
```

## Schedule

The following table maps the JavaFX 17 release schedule to the channels of the OpenJFX Snap package. The channel columns show the JavaFX release found on the channel during each phase of the schedule.

| Date       | Phase                     | Stable | Candidate | Beta | Edge |
| ---------- | ------------------------- |:------:|:---------:|:----:|:----:|
| 2021-03-09 | Current Release           | 16 | ←  | ←  | 17 |
| 2021-07-08 | Rampdown Phase One        | 16 | ←  | 17 | 18 |
| 2021-07-29 | Rampdown Phase Two        | 16 | ←  | 17 | 18 |
| 2021-08-19 | Release Candidate Freeze  | 16 | 17 | ←  | 18 |
| 2021-09-07 | General Availability      | 17 | ←  | ←  | 18 |

The leftwards arrow symbol (←) indicates that the channel is closed. When a specific risk-level channel is closed, the Snap Store will select the package from the more conservative risk level to the left in the table. If the channel is re-opened, packages will once again be selected from the original channel.

## Trust

The steps in building the packages are open and transparent so that you can gain trust in the process that creates them instead of having to put all of your trust in their publisher.

| Channel   | Branch         | Source           | Package                |
| --------- | -------------- | ---------------- | ---------------------- |
| candidate | [candidate][1] | [openjdk/jfx][4] | [openjfx-candidate][5] |
| beta      | [beta][2]      | [openjdk/jfx][4] | [openjfx-beta][6]      |
| edge      | [edge][3]      | [openjdk/jfx][4] | [openjfx-edge][7]      |

[1]: https://github.com/jgneff/openjfx/tree/candidate
[2]: https://github.com/jgneff/openjfx/tree/beta
[3]: https://github.com/jgneff/openjfx/tree/edge

[4]: https://github.com/openjdk/jfx/tags

[5]: https://launchpad.net/~jgneff/openjfx-snap/+snap/openjfx-candidate
[6]: https://launchpad.net/~jgneff/openjfx-snap/+snap/openjfx-beta
[7]: https://launchpad.net/~jgneff/openjfx-snap/+snap/openjfx-edge

For each of the three channels, the table above links to:

* the branch of this repository that creates the Snap package,
* the release tags of the OpenJFX source code repository on GitHub, and
* the package information and latest builds on Launchpad.

General-availability releases published to the *candidate* channel are eventually promoted to the *stable* channel.

The [Launchpad build farm](https://launchpad.net/builders) runs each build in a transient container created from trusted images to ensure a clean and isolated build environment. Snap packages built on Launchpad include a manifest that lets you verify the build and identify its dependencies.

## Verify

Each OpenJFX package provides a software bill of materials (SBOM) and a link to its build logs. This information is contained in a file called `manifest.yaml` in the directory `/snap/openjfx/current/snap`. The section `image-info` provides a link to a page on Launchpad with the build status and details, including the log file from the machine where it ran. The log file lets you verify that the package was built from source using only the software in [Ubuntu 18.04 LTS](https://cloud-images.ubuntu.com/bionic/current/) and the official [Gradle releases](https://gradle.org/releases/).

For example, the current revision of the OpenJFX 16 package for *amd64* shows:

```yaml
image-info:
  build-request-id: lp-62797256
  build-request-timestamp: '2021-03-10T18:17:22Z'
  build_url: https://launchpad.net/~jgneff/+snap/openjfx-candidate/+build/1328667
```

The `image-info` section is followed by other sections that provide the name and version of each package used during the build and any packages included in the run-time image.

Having a transparent build process is a good first step, but the only conclusive way to verify a software package is to reproduce it. That's the main recommendation in the article [Preventing Supply Chain Attacks like SolarWinds](https://www.linuxfoundation.org/en/blog/preventing-supply-chain-attacks-like-solarwinds) by David Wheeler, Director of Open Source Supply Chain Security at the Linux Foundation. "In the longer term," he writes, "I know of only one strong countermeasure for this kind of attack: verified reproducible builds." The OpenJFX project has only just started to [add the necessary support](https://github.com/openjdk/jfx/pull/446).

## Usage

Once installed, the OpenJFX Snap package includes the following directories:

* `/snap/openjfx/current/jmods` - JMOD archives for `jlink`
* `/snap/openjfx/current/sdk/api` - Javadoc API documentation
* `/snap/openjfx/current/sdk/lib` - Modular JAR files and native libraries
* `/snap/openjfx/current/sdk/src` - Java source code of JavaFX

On Fedora-based systems, these directories are found under the root directory `/var/lib/snapd` instead of the locations shown above for Debian-based systems.

The JDK tools need to know two locations: the JavaFX library directory and the JMOD archives directory. The OpenJFX Snap package provides these locations with two environment variables, as described below.

The `openjfx` command prints the location of a file that defines the environment variables:

```console
$ openjfx
/var/snap/openjfx/common/openjfx.env
```

The file exports the `JAVAFX_LIB` and `JAVAFX_MOD` environment variables:

```console
$ cat $(openjfx)
# Source this file for OpenJFX environment variables
export JAVAFX_LIB=/snap/openjfx/x1/sdk/lib
export JAVAFX_MOD=/snap/openjfx/x1/jmods
```

To set the variables in your current shell, use the `source` or "dot" (`.`) command to read and execute the commands from the file:

```console
$ . $(openjfx)
```

You can then verify that `JAVAFX_LIB` and `JAVAFX_MOD` are defined with:

```console
$ printenv | grep JAVAFX
JAVAFX_LIB=/snap/openjfx/x1/sdk/lib
JAVAFX_MOD=/snap/openjfx/x1/jmods
```

Once defined, you can use these variables in arguments to the `java`, `javac`, `javadoc`, `jlink`, and `jpackage` tools of the JDK.

## Contributing

Ultimately, I would like to see the latest OpenJFX release available in the package repositories of all Linux distributions. Then on Ubuntu 20.04 LTS, for example, you could install it with a command like the following:

```console
$ sudo apt install openjfx-16-sdk
```

Until that time, this Snap package can serve as a temporary solution by providing the latest OpenJFX release on as many Linux distributions and architectures as possible. I welcome your help and support.

## Building

On Linux systems, you can build the Snap package directly by installing [Snapcraft](https://snapcraft.io/snapcraft) on your development workstation. The bottom of the Snapcraft page shows how to enable Snaps for your Linux distribution.

Whether you're running Windows, macOS, or Linux, you can use [Multipass](https://multipass.run) to build this project in an Ubuntu virtual machine (VM). For example, the following command will launch the Multipass [primary instance](https://multipass.run/docs/primary-instance) with 2 CPUs, 4 GiB of RAM, and Ubuntu 20.04 LTS (Focal Fossa):

```console
$ multipass launch --name primary --cpus 2 --mem 4G focal
```

The `snap/snapcraft.yaml` files on the *candidate*, *beta*, and *edge* branches define the build of the Snap package. Run the following commands to install Snapcraft, clone this repository, and start building the package:

```console
$ sudo snap install snapcraft
$ git clone https://github.com/jgneff/openjfx.git
$ cd openjfx
$ snapcraft
```

Snapcraft launches a new Multipass VM to ensure a clean and isolated build environment. The VM is named `snapcraft-openjfx` and runs Ubuntu 18.04 LTS (Bionic Beaver). The project's directory on the host system is mounted as `/root/project` in the guest VM, so any changes you make on the host are seen immediately in the guest, and vice versa.

**Note:** If you run the initial `snapcraft` command itself inside a VM, your system will need *nested VM* functionality. See the [Build Options](https://snapcraft.io/docs/build-options) page for alternatives, such as running a remote build or using an LXD container.

If the build fails, you can run the command again with the `--debug` (or `-d`) option to remain in the VM after the error:

```console
$ snapcraft -d
```

From within the VM, you can then clean the Snapcraft part and try again:

```console
# snapcraft clean jfx
Cleaning pull step (and all subsequent steps) for jfx
# snapcraft
  ...
BUILD SUCCESSFUL in 2m 3s
136 actionable tasks: 136 executed
  ...
Priming jfx
+ snapcraftctl prime
The 'jfx' part is missing libraries that are not included in the snap or base.
They can be satisfied by adding the following entry for this part
stage-packages:
  ...
Snapping...
Snapped openjfx_18+2_amd64.snap
```

When the build completes, you'll find the Snap package in the project's root directory, along with the log file if you ran the build remotely.

## License and Trademarks

This project is licensed under the GNU General Public License v2.0 with the Classpath exception, the same license used by Oracle for the OpenJFX project. See the files [LICENSE](LICENSE) and [ADDITIONAL_LICENSE_INFO](ADDITIONAL_LICENSE_INFO) for details.

Java, JavaFX, and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. See the file [TRADEMARK](TRADEMARK) for details.
