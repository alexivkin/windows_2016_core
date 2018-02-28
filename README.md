# Windows 2016 Core optimized build

This is a [packer](https://www.packer.io/) build environment for the windows server core base VM for Virtual Box, based on scripts from [Stefan Scherer](https://github.com/StefanScherer/packer-windows) and [Joe Fitzgerald](https://github.com/joefitzgerald/packer-windows)

The default build based on an eval version of the windows server core 2016 (9PBKX-... product key) which is good for 6 months, at which time you can rebuild the system to refresh the trial. Alternatively you can specify your own key and the ISO (see below).

This repo is here for all you security minded people to validate that there is no funny stuff inserted into the resulting VM.

Things that are done during the build:
* Latest updates and virtualbox guest tools are installed
* RDP, UAC and WinRM are enabled
* Telemetry and screensaver are disabled
* Windows defender removed
* Disk cleaned up

The only external tool used in the build is Microsoft's sdelete. It is here because there is no built-in windows way to zero out a disk for the vbox size reduction.

# Building
`packer build packer.json`

A trial WSC 2016 ISO will be downloaded from Microsoft and cached on the first build. Once the build is done, add it to the list of availabe boxes:

`vagrant box add wsc windows_2016_core_virtualbox.box`

Then you can use the box in your vagrant machines by specifying the following in the Vagrantfile

`config.vm.box = "alexivkin/windows_2016_core"`

## Product Keys
If you would like to use a retail or a volume license ISO, you need to update the `UserData` ->`ProductKey` in the Autounattend.xml and then run packer on a pre-downloaded iso like this:

`packer build --only=virtualbox-iso --var iso_url=./iso/en_windows_server_2016_x64_dvd_9718492.iso --var iso_checksum=F185197AF68FAE4F0E06510A4579FC511BA27616 --var iso_checksum_type=sha1 --var autounattend=./Autounattend.xml packer.json`

### How long is my trial Windows Server Core VM is valid for?
The validity can be see in the event log -> apoplication -> security-SPP, event ID 1037

## Testing and development
The Autonunattend.xml script will install all the windows updates during the build, which is a *very* time consuming process. You  might want to disable this functionality by uncommenting the `WITHOUT WINDOWS UPDATES` and commenting out the `WITH WINDOWS UPDATES` sections.

To upload the box into the vagrant could you will need to use the vagrant cloud web interface or the API as documented [here](https://www.vagrantup.com/docs/vagrant-cloud/boxes/create.html). In the past you could have used the `packer push alexivkin/windows_2016_core` command.

## Todo
* Audio in or out is disabled by default
* More cleaning can be done by downloading and running bleachbit
