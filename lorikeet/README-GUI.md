 
 #Rainbow Lorikeet GUI Provisioning
 
 This guide explains how to provision GUID access for ParrotOS inside WSL using the 'install.sh' script.
 
 ## Prerequisites
 
 -ParrotOS running under WSL2
 -WSLg enabled for native GUI support
 -Git cloned 'rainbow-lorikeet/lorikeet' repo
 
 ## Usage
 
```bash
./install.sh

 ## Session Lifecycle and Security Tip
 
 Keep Windows Terminal open while using XRDP. This ensures the WSL2 instance stays alive during your remote session. When you close the terminal, the XRDP service shuts down cleanly, guaranteeing that no lingering sessions remain. This practice enhances security by making session termination explicit and predictable — ideal for contributor workflows and forensic clarity.
