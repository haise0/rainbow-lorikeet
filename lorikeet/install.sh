#!/bin/bash
# Rainbow Lorikeet Installer for ParrotOS in WSL2
# Author: Lee + Copilot
# Purpose: Bootstrap GUI environment with optional Xfce and XRDP/VNC toggle

set -e

echo "Starting Rainbow Lorikeet install for ParrotOS in WSL2..."

# Detect WSLg
if [ -n "$WAYLAND_DISPLAY" ]; then
  echo "WSLg detected — GUI apps can launch natively."
else
  echo "SLg not detected — will configure remote GUI access."
fi

# Update and install core GUI packages
echo "Installing base GUI packages..."
sudo apt update
sudo apt install -y dbus-x11 x11-utils x11-xserver-utils

# Optional: Install Xfce
read -p "Would you like to install Xfce alongside KDE? (y/n): " install_xfce
if [ "$install_xfce" = "y" ]; then
  echo "Installing Xfce..."
  sudo apt install -y xfce4 xfce4-goodies
  echo "Xfce installed."
else
  echo "Skipping Xfce install."
fi

# Choose XRDP or VNC
read -p "Use XRDP instead of VNC for remote desktop? (y/n): " use_xrdp
if [ "$use_xrdp" = "y" ]; then
  echo "Installing XRDP..."
  sudo apt install -y xrdp
  sudo systemctl enable xrdp
  sudo systemctl start xrdp
  echo "startxfce4" > ~/.xsession  # Or use startplasma-x11 if KDE is preferred
  echo "XRDP installed. Connect via Remote Desktop to localhost:3389"
else
  echo "Installing VNC server..."
  sudo apt install -y tightvncserver
  mkdir -p ~/.vnc
  cat <<EOF > ~/.vnc/xstartup
#!/bin/bash
xrdb \$HOME/.Xresources
startxfce4 &
EOF
  chmod +x ~/.vnc/xstartup
  echo "VNC configured. Start with: vncserver :1 and connect to localhost:5901"
fi

# Clean up and confirm
echo "Installation complete."
echo "You can now launch GUI apps directly if WSLg is active."

# Optional: Log semantic trust event
# echo "event=rainbow_lorikeet_install_script_ran, platform=ParrotOS, method=WSL2, timestamp=$(date -Iseconds)" >> ~/ssh_keygrid_AD/trust.log
