# What is PacCache?
A caching package proxy for Pacman (Arch Linux) (although it probably can be adjusted for any package manager).

### Why?
If you have multiple [Arch Linux](https://archlinux.org) machines on your network; using this image can help speed up downloads and reduce network consumption.

### How does it work?
It's really just a fancy NGINX Config adapted from [this](https://github.com/nastasie-octavian/nginx_pacman_cache_config/blob/87d4897b8fa37e70da4238d7074c639c041daf39/nginx.conf).

Once properly setup, when the Container recieves a request for a package that isn't present locally, it downloads it from the primary mirror and saves the .pkg.tar.xz file to disk. 

Any requests for .db or .sig files are *always* sent upstream to the mirror.

### How do I use it?
`docker run -d --name --paccache -p 8080:8080 -v /path/to/data/dir:/cache:rw -e okamidash/paccache`

#### Environment Variables
- `DNS_SERVER` DNS Server to use for NGINX. You can change this to any DNS you want. 
   
   **default:** `1.1.1.1`

- `SERVER_NAME`Domain Name/IP of Container. The default will respond to all requests.
   
   **default:** `_`

- `PRIMARY_MIRROR` Primary mirror to use for proxying requests. It is **recommended** to change this.
   
   **default:** `https://mirrors.ukfast.co.uk/sites/archlinux.org`

- `BACKUP_MIRROR` Backup mirror incase the primary mirror is down. 

   **default:** `https://archlinux.uk.mirror.allworldit.com/archlinux`
   
#### Changing the Default Mirrors
It is recommended that you change the default mirrors to ones that are closer to you. 

Currently the Docker Container only supports ipv4 http and https, no Rsync or ftp yet.

To change them, I would suggest using [Reflector](https://xyne.archlinux.ca/projects/reflector/).

Something like `reflector -p http -p https -l 50 --ipv4 -f 10 --sort rate` will return the 10 fastest mirrors.

You will get a result like this.
```
Server = https://archlinux.uk.mirror.allworldit.com/archlinux/$repo/os/$arch
Server = https://archlinux.mailtunnel.eu/$repo/os/$arch
Server = https://mirror.orbit-os.com/archlinux/$repo/os/$arch
Server = https://pkg.adfinis-sygroup.ch/archlinux/$repo/os/$arch
Server = http://mirror.cyberbits.eu/archlinux/$repo/os/$arch
```
You only need to trim everything from $repo onwards; so `https://archlinux.mailtunnel.eu/$repo/os/$arch` will be `https://archlinux.mailtunnel.eu/`
and `https://archlinux.uk.mirror.allworldit.com/archlinux/$repo/os/$arch` becomes `https://archlinux.uk.mirror.allworldit.com/archlinux/`

### Configuring /etc/pacman.d/mirrorlist
`Server = http://container_ip:container_port/$repo/os/$arch`

Example using a container IP of 10.0.20.1, and `-p 8080:8080`

`Server = http://10.0.20.1:8080/$repo/os/$arch`

### Need help?
If you need any help, feel free to email me

`okami @ doubledash.org`


This is my first Docker Image, and I had help from friends building it; so I can't promise i'll be helpful.
