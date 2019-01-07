# image-hipstafier

## hipstafy-daemon.sh
Usage: **./hipstafy-daemon.sh <start|stop|status|restart>**
Interface to run hipstafy-wait.sh as a daemon

## hipstafy-url.sh
Usage: **./hipstafy-url.sh <image_url>**

Downloads an image from the specified url, converts and uploads it to imgur.com using Imgur API

## hipstafy-wait.sh	
Required packages: **inotify-tools**

Usage: **./hipstafy-wait.sh	<directory_path>**

Monitors the specified directory for incoming images and converts them using **hipstafy.sh**

## hipstafy.sh
Required packages: **imagemagick**

Usage: **./hipstafy.sh <image_path> \[out_path\]**

Converts the specified image to a yellowish polaroid one and saves it to the disk.
