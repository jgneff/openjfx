![OpenJFX: Current JavaFX release and early-access builds](images/banner.svg)

OpenJFX is the open-source project that develops JavaFX. This project builds [Snap packages](https://snapcraft.io/openjfx) of OpenJFX directly from its [source repository](https://github.com/openjdk/jfx) on GitHub. These packages, together with OpenJDK 21 or later, provide everything you need to develop a JavaFX application on Linux, including all of the latest JAR files, native libraries, JMOD archives, API documentation, and source code of JavaFX.

The branches of this repository publish the JavaFX general-availability (GA) release and early-access (EA) builds for six hardware platforms. They are listed below by their Debian architecture, machine hardware name, and Java architecture:

| Debian  | Machine | Java    | JavaFX GA | JavaFX EA |
|:-------:|:-------:|:-------:|:---------:|:---------:|
| amd64   | x86_64  | amd64   | ✓ | ✓ |
| arm64   | aarch64 | aarch64 | ✓ | ✓ |
| armhf   | armv7l  | arm     | ✓ | ✓ |
| i386    | i686    | i386    | ✓ | ✓ |
| ppc64el | ppc64le | ppc64le | ✓ | ✓ |
| s390x   | s390x   | s390x   | ✓ | ✓ |

**Note:** The branches of this repository are named after the Snap channels where the builds are published: *edge*, *beta*, *candidate*, and *stable*. The HEAD branch is *edge*, and merges follow the Snap package releases from *edge* into *beta*, *beta* into *candidate*, and *candidate* into *stable*.

## See also

This project is one of four that I created to gain control of my development environment:

* [OpenJDK](https://github.com/jgneff/openjdk) - Current JDK release and early-access builds

    [![openjdk](https://snapcraft.io/openjdk/badge.svg)](https://snapcraft.io/openjdk)

* [OpenJFX](https://github.com/jgneff/openjfx) - Current JavaFX release and early-access builds

    [![openjfx](https://snapcraft.io/openjfx/badge.svg)](https://snapcraft.io/openjfx)

* [Strictly Maven](https://github.com/jgneff/strictly-maven) - Apache Maven™ in a strictly-confined snap

    [![strictly-maven](https://snapcraft.io/strictly-maven/badge.svg)](https://snapcraft.io/strictly-maven)

* [Strictly NetBeans](https://github.com/jgneff/strictly-netbeans) - Apache NetBeans® in a strictly-confined snap

    [![strictly-netbeans](https://snapcraft.io/strictly-netbeans/badge.svg)](https://snapcraft.io/strictly-netbeans)

## Schedule

The table below contains the most recent schedule for OpenJFX. The channel columns show the JavaFX releases found on the channels during each phase of the schedule.

| Date       | Phase                    | Stable | Candidate | Beta | Edge |
| ---------- | ------------------------ |:------:|:---------:|:----:|:----:|
| 2023-09-19 | General Availability     | 21 | ←  | ←  | 22 |
| 2024-01-11 | Rampdown Phase One       | 21 | ←  | 22 | 23 |
| 2024-02-01 | Rampdown Phase Two       | 21 | ←  | 22 | 23 |
| 2024-02-29 | Release Candidate Freeze | 21 | 22 | ←  | 23 |
| 2024-03-19 | General Availability     | 22 | ←  | ←  | 23 |

The leftwards arrow (←) indicates that the channel is closed. When a specific risk-level channel is closed, the Snap Store will select the package from the more conservative risk level in the column to its left. If the channel is re-opened, packages will once again be selected from the original channel.

## Install

Install the OpenJFX Snap package with the command:

```console
$ sudo snap install openjfx
```

The Snap package is [strictly confined](https://snapcraft.io/docs/snap-confinement) and adds no [interfaces](https://snapcraft.io/docs/supported-interfaces) to its permissions.

Install the OpenJFX Snap package from a channel other than the *stable* channel with one of the following commands:

```console
$ sudo snap install openjfx --candidate
$ sudo snap install openjfx --beta
$ sudo snap install openjfx --edge
```

You will also need the Java Development Kit (JDK). You can install the [OpenJDK Snap package](https://snapcraft.io/openjdk) to get the current JDK release or an early-access build:

```console
$ sudo snap install openjdk
```

When you install the OpenJDK and OpenJFX Snap packages, they connect automatically, allowing you to develop and deploy both Java and JavaFX applications. For example, installing the latest OpenJDK and OpenJFX Snap packages results in the following connection:

```console
$ snap connections openjfx
Interface             Plug                 Slot                 Notes
content               -                    openjfx:jfx-20-1804  -
content[jfx-21-1804]  openjdk:jfx-21-1804  openjfx:jfx-21-1804  -
```

This connection provides the OpenJDK Snap package with read access to the OpenJFX Software Development Kit (SDK) and shared libraries so that you can compile, package, link, and run JavaFX applications.

## Trust

The steps in building the packages are open and transparent so that you can gain trust in the process that creates them instead of having to put all of your trust in their publisher.

| Snap Channel | Build File          | Source Code         | Snap Package           |
| ------------ | ------------------- | ------------------- | ---------------------- |
| candidate    | [snapcraft.yaml][1] | [openjdk/jfx21u][4] | [openjfx-candidate][7] |
| beta         | [snapcraft.yaml][2] | [openjdk/jfx22u][5] | [openjfx-beta][8]      |
| edge         | [snapcraft.yaml][3] | [openjdk/jfx][6]    | [openjfx-edge][9]      |

[1]: https://github.com/jgneff/openjfx/blob/candidate/snap/snapcraft.yaml
[2]: https://github.com/jgneff/openjfx/blob/beta/snap/snapcraft.yaml
[3]: https://github.com/jgneff/openjfx/blob/edge/snap/snapcraft.yaml

[4]: https://github.com/openjdk/jfx21u/tags
[5]: https://github.com/openjdk/jfx22u/tags
[6]: https://github.com/openjdk/jfx/tags

[7]: https://launchpad.net/~jgneff/openjfx-snap/+snap/openjfx-candidate
[8]: https://launchpad.net/~jgneff/openjfx-snap/+snap/openjfx-beta
[9]: https://launchpad.net/~jgneff/openjfx-snap/+snap/openjfx-edge

For each of the three channels, the table above links to:

* the Snapcraft build file that creates the Snap package,
* the release tags used to obtain the OpenJFX source code, and
* information about the package and its latest builds on Launchpad.

General-availability releases published to the *candidate* channel are eventually promoted to the *stable* channel.

The [Launchpad build farm](https://launchpad.net/builders) runs each build in a transient container created from trusted images to ensure a clean and isolated build environment. Snap packages built on Launchpad include a manifest that lets you verify the build and identify its dependencies.

## Verify

Each OpenJFX package provides a software bill of materials (SBOM) and a link to its build log. This information is contained in a file called `manifest.yaml` in the directory `/snap/openjfx/current/snap`. The `image-info` section of the manifest provides a link to the package's page on Launchpad with its build status, including the complete log file from the container that ran the build. You can use this information to verify that the OpenJFX Snap package installed on your system was built from source on Launchpad using only the software in [Ubuntu 18.04 LTS](https://cloud-images.ubuntu.com/bionic/current/) and the official [Gradle releases](https://gradle.org/releases/).

For example, I'll demonstrate how I verify the OpenJFX Snap package installed on my system at the time of this writing. The `snap info` command shows that I installed OpenJFX version 19+11 with revision 512, the revision for the *amd64* architecture:

```console
$ snap info openjfx
...
channels:
  latest/stable:    19+11 2022-09-16 (512) 103MB -
  latest/candidate: ↑
  latest/beta:      ↑
  latest/edge:      20+3  2022-09-16 (511) 103MB -
installed:          19+11            (512) 103MB -
```

The following command prints the build information from the manifest file:

```console
$ grep -A3 image-info /snap/openjfx/current/snap/manifest.yaml
image-info:
  build-request-id: lp-74095810
  build-request-timestamp: '2022-09-16T16:00:56Z'
  build_url: https://launchpad.net/~jgneff/openjfx-snap/+snap/openjfx-candidate/+build/1882555
```

The `build_url` in the manifest is a link to the [page on Launchpad](https://launchpad.net/~jgneff/openjfx-snap/+snap/openjfx-candidate/+build/1882555) with the package's **Build status** and **Store status**. The store status shows that Launchpad uploaded revision 512 to the Snap Store, which matches the revision installed on my system. The build status shows a link to the log file with the label *buildlog*.

The end of the log file contains a line with the SHA512 checksum of the package just built, shown below with the checksum edited to fit on this page:

```
Snapping...
Snapped openjfx_19+11_amd64.snap
Starting Snapcraft 7.1.3
Logging execution to
  '/root/.cache/snapcraft/log/snapcraft-20220916-160844.287206.log'
da3302f078740d55...0a38cea62d6b18b1  openjfx_19+11_amd64.snap
Revoking proxy token...
```

The command below prints the checksum of the package installed on my system:

```console
$ sudo sha512sum /var/lib/snapd/snaps/openjfx_512.snap
da3302f078740d55...0a38cea62d6b18b1  /var/lib/snapd/snaps/openjfx_512.snap
```

The two checksum strings are identical. Using this procedure, I verified that the OpenJFX Snap package installed on my system and the OpenJFX Snap package built and uploaded to the Snap Store by Launchpad are in fact the exact same package. For more information, see [Launchpad Bug #1979844](https://bugs.launchpad.net/launchpad/+bug/1979844), "Allow verifying that a snap recipe build corresponds to a store revision."

## Usage

Once installed, the OpenJFX Snap package includes the following directories:

* `/snap/openjfx/current/sdk/api` - Javadoc API documentation
* `/snap/openjfx/current/sdk/jmods` - JMOD archives for `jlink`
* `/snap/openjfx/current/sdk/lib` - Modular JAR files and native libraries
* `/snap/openjfx/current/sdk/src` - Java source code of JavaFX

On Fedora-based systems, these directories are found under the root directory `/var/lib/snapd` as a prefix to the locations shown above for Debian-based systems.

The JDK tools need to know two locations: the JavaFX library directory and the JMOD archives directory. The OpenJFX Snap package provides these locations with two environment variables, as described below.

The `openjfx` command prints the location of a file that defines the environment variables:

```console
$ openjfx
/var/snap/openjfx/x1/openjfx.env
```

The file exports the `JAVAFX_LIB` and `JAVAFX_MOD` environment variables:

```console
$ cat $(openjfx)
# Source this file for OpenJFX environment variables
export JAVAFX_LIB=/snap/openjfx/x1/sdk/lib
export JAVAFX_MOD=/snap/openjfx/x1/sdk/jmods
```

To set the variables in your current shell, use the `source` or "dot" (`.`) command to read and execute the commands from the file:

```console
$ . $(openjfx)
```

You can then verify that `JAVAFX_LIB` and `JAVAFX_MOD` are defined with:

```console
$ printenv | grep JAVAFX
JAVAFX_LIB=/snap/openjfx/x1/sdk/lib
JAVAFX_MOD=/snap/openjfx/x1/sdk/jmods
```

You can also manually set the environment variables to fixed locations that don't depend on the Snap revision number, as shown below:

```console
$ export JAVAFX_LIB=/snap/openjfx/current/sdk/lib
$ export JAVAFX_MOD=/snap/openjfx/current/sdk/jmods
```

Once defined, you can use these variables in arguments to the `java`, `javac`, `javadoc`, `jlink`, and `jpackage` tools of the JDK.

## Build

You can build the Snap package on Linux by installing [Snapcraft](https://snapcraft.io/snapcraft) on your development workstation. The `snap/snapcraft.yaml` files on the *candidate*, *beta*, and *edge* branches define the build for each channel. Run the following commands to install Snapcraft, clone this repository, and start building the package:

```console
$ sudo snap install snapcraft --classic
$ git clone https://github.com/jgneff/openjfx.git
$ cd openjfx
$ snapcraft
```

To run the build remotely on Launchpad, enter the command:

```console
$ snapcraft remote-build
```

See the [Snapcraft Overview](https://snapcraft.io/docs/snapcraft-overview) page for more information about building Snap packages.

## License

This project is licensed under the GNU General Public License v2.0 with the Classpath exception, the same license used by Oracle for the OpenJFX project. See the files [LICENSE](LICENSE), [ADDITIONAL_LICENSE_INFO](ADDITIONAL_LICENSE_INFO), and [ASSEMBLY_EXCEPTION](ASSEMBLY_EXCEPTION) for details.

Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. See the file [TRADEMARK](TRADEMARK) for details.
