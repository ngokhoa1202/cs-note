

Travis CI supports various [databases](https://docs.travis-ci.com/user/database-setup/), such as MySQL, PostgreSQL, MariaDB, MongoDB, CouchDB, Redis, Cassandra, and Memcached.

The build phase is supported by various isolation environments, such as Docker, LXD containers, Linux VMs, and various operating systems, such as MacOS, Ubuntu Linux, Windows Server, and FreeBSD.

Travis CI supports several languages,  such as C, C++, C#, Visual Basic, Go, Java, Matlab, Perl, PHP, Python, Ruby, and Rust, just to name a few. For a detailed list of all supported languages, please visit the "_[Language-specific Guides](https://docs.travis-ci.com/user/language-specific/)_" page.

After running the test, we can deploy the application on many cloud providers, such as Heroku, AWS, Azure, Cloud Foundry, Google Cloud, and OpenShift. A detailed list of providers is available on the "_[Supported Providers](https://docs.travis-ci.com/user/deployment)_" page.

# Demo
Let's illustrate how to build a Github hosted project with Travis CI.

_**NOTE**: The following set of screenshots may have a different look on your system. Both GitHub and the Travis CI dashboard UI features may change without notice._

The sample repository holds a Python script and the required **.travis.yml** file.

![The sample repository holds a Python script and the required .travis.yml file](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_sample_repository_holds_a_Python_script_and_the_required_.travis.yml_file.png)

The simple Python script produces the “Hello world!” output.

![The simple Python script produces the “Hello world!” output](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@The_simple_Python_script_produces_the__Hello_world___output.png)

The **.travis.yml** file stores the build configuration for Travis CI.

![The .travis.yml file stores the build configuration for Travis CI](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_.travis.yml_file_stores_the_build_configuration_for_Travis_CI.png)

The Travis CI dashboard lists the GitHub repositories which have been activated and migrated to Travis CI under the Active repositories tab. Newly migrated repos display the _Trigger a build_ button. Once a build is complete on a repo, it is listed under the My builds tab.

![The Travis CI dashboard](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_Travis_CI_dashboard.png)

A completed build can be inspected by clicking the build index.

![A completed build can be inspected by clicking the build index](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/A_completed_build_can_be_inspected_by_clicking_the_build_index.png)

The build logs display a summary of the build environment.

![The build logs display a summary of the build environment](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block@The_build_logs_display_a_summary_of_the_build_environment_Updated1.png)

After scrolling down the dashboard displays detailed build logs in a terminal-like view.

![The dashboard displays detailed build logs in a terminal-like view](https://courses.edx.org/asset-v1:LinuxFoundationX+LFS151.x+2T2023+type@asset+block/The_dashboard_displays_detailed_build_logs_in_a_terminal-like_view.png)