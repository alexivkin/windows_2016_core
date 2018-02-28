@echo off
rem requires "guest_additions_mode": "attach", in packer.json
if not exist "e:\VBoxWindowsAdditions.exe" (
    echo Guest additions are not mounted.
    exit 0
)
echo Installing guest additions.

certutil -addstore -f "TrustedPublisher" e:\cert\vbox-sha256-r3.cer
certutil -addstore -f "TrustedPublisher" e:\cert\vbox-sha256.cer
certutil -addstore -f "TrustedPublisher" e:\cert\vbox-sha1.cer
e:\VBoxWindowsAdditions.exe /S
