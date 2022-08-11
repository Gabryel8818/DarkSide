#!/usr/bin/env bash 

PACKAGES=(python3 neofetch python3-pip)

install_ubuntu_like_packages(){
  apt-get update -y 
  for package in $PACKAGES;do
    apt-get install $package
    if [ "$package" == "neofetch" ]; then
      elif [ "$?" -eq 0 ]; then
        add-apt-repository ppa:dawidd0811/neofetch
        apt-get update
        apt-get install neofetch
      fi
    echo "Installed!"
  done
  python3 -m pip install -r requirements.txt
}

install_fedora_like_packages(){
  dnf install neofetch python3 python3-pip 
  python3 -m pip install -r requirements.txt 
  echo "Installed!"
}


check_os(){
  OS=$(grep -i ID_LIKE /etc/os-release | cut -d'=' -f 2)

  case $OS in
   'ubuntu')
     install_ubuntu_like_packages
     ;;
   'fedora'|'centos'|'rhel')
     install_fedora_like_packages
     ;;
   'WindowsNT')
     OS='Windows';;
   'Darwin') 
     OS='Mac';;
   'SunOS')
     OS='Solaris';;
   'AIX') ;;
   *) ;;
  esac
}

checkroot() {

if [ "$(id -u)" -ne 0 ]; then
   printf "\e[1;77mPlease, run this program as root!\n\e[0m"
   exit 1
fi

}
