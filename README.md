# UserFold
This script transfers your entire user folder outside of C:\ and rearranges the folders so that you can always find everything right from the desktop.
## Why?
[Because you don't know what a folder is.](https://futurism.com/the-byte/gen-z-kids-file-systems)

## Requirements
* A Ventoy USB drive with at least two Windows ISO's. This operation cannot be reversed, and the only way to restore your original user folder location is to clean reinstall Windows.
* A Z:\ drive. It is heavily recommended to map the drive to Z:\ for easier SMB.
* The Z:\ drive MUST be NTFS, REFS, or another file system that is HEAVILY resistant to data corruption. [BTRFS OR OTHER LINUX """FILE SYSTEMS""" DO NOT COUNT!!!!!](https://fy.blackhats.net.au/blog/2024-08-13-linux-filesystems/)
* You MUST have a backup of all your data UNPLUGGED from anything before proceeding.

## Usage
```
Invoke-Expression ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/MilesFarber/UserFold/Leader/Z.ps1'))
```
