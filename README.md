# Windows 2016 Core optimized build

This is a [packer](https://www.packer.io/) build environment for the windows server core base VM. Virtual Box only, based on scripts from [Stefan Scherer] (https://github.com/StefanScherer/packer-windows and [Joe Fitzgerald](https://github.com/joefitzgerald/packer-windows)

The default build based on the eval version of 2016 (9PBKX key), good for 6 months, at which time you can just rebuild the system. You can specify your own keys and ISOs.

This repo is open for all you security minded people to validate that there is no funny stuff inserted into the resulting box.

Things that are done during the build:
* Latest updates are installed
* Virtual box guest tools installed
* Enabled RDP, UAC, WinRM
* Disabled telemetry and screensaver
* Removed m$ defender, disk cleaned up

The only external tool used is sdelete, because there is no built-in windows way to zero out disk to make it suitable for vbox size reduction.

# Building
The trial ISO will be downloaded from Microsoft and cached on the first build.
`packer build packer.json`

once build is done add to the list of availabe boxes
`vagrant box add wsc windows_2016_core_virtualbox.box`

Then you can use it to base your vagrant machines by specifying it as the following in the vagrantfile
`config.vm.box = "symbols/windows_2016_core"`

## Product Keys
If you would like to use retail or volume license ISOs, you need to update the `UserData` ->`ProductKey` in the Autounattend.xml and then run it on a pre-downloaded iso like this
`packer build --only=virtualbox-iso --var iso_url=./iso/en_windows_server_2016_x64_dvd_9718492.iso --var iso_checksum=F185197AF68FAE4F0E06510A4579FC511BA27616 --var iso_checksum_type=sha1 --var autounattend=./Autounattend.xml packer.json`

### How long is my trial WSC VM is valid for?
The validity can be see in the event log -> apoplication -> security-SPP, event ID 1037

## Todo
* audio in or out is disabled by default
* more cleaning can be done by downloading and running bleachbit

## Testing and development
The autonunattend.xml script will install all Windows updates during the build, which is a _very_ time consuming process. You  might want to disable this functionality by uncommenting the `WITHOUT WINDOWS UPDATES` and commenting out the `WITH WINDOWS UPDATES` sections

To upload the box you build with this code use
