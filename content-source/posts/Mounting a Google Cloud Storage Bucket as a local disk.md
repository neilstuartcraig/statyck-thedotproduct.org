These days it's a pretty common usage pattern to store files of all sorts in a "storage as a service" offering such as Google Cloud Storage (GCS).
It's simple enough to push and pull content to and from GCS but if, for example, you want to store your static website in GCS and serve it to the internet, what do you do?
A simple solution might be to periodically sync the content of your GCS bucket to the local filesystem of your server(s) but that's got inherent lag due to the periodicity of the sync. Enter GCSFuse...

## GCSFuse
[GCSFuse](https://cloud.google.com/storage/docs/gcs-fuse) is an implementation of the [Fuse](https://github.com/libfuse/libfuse) filesystem which allows you to mount your GCS bucket on your server(s). That's pretty awesome as it means that functionally, you can treat your GCS bucket and the files (well, technically objects since GCS is an object store, not a filesystem) it contains as if they were on a physical or networked volume. Admittedly there's some lag in the transfer to and from GCS but for many read-only use cases (as a static website would be), that's only really an issue on the first access of a file as the file is cached by the operating system. You're currently reading content served in exactly this way. 

If this sounds like a solution you might find useful, the good news is that it's incredibly simple to get started. I'm going to assume that your use case is like mine, i.e.:

* You only ever read files from your GCS bucket from the server(s) on which you'll mount your GCS bucket
* You have a relatively small number of small (i.e. KB not MB) objects you want to serve (few enough that the OS can cache them effectively

## Installation
Follow the [installation instructions](https://github.com/GoogleCloudPlatform/gcsfuse/blob/master/docs/installing.md) for your OS. This essentially boils down to:

* Add the `deb` or `yum` repo
* `apt-get install` or `yum install` the GCSFuse package

It really is _that simple_

##  Configuration
All you need to do now is mount the volume in `read-only` mode via your `fstab`. We'll assume that:

* Your GCS bucket is called `MY-GCS-BUCKET`
* You want to mount the bucket at `/mnt/MY-GCS-BUCKET`
* Your OS has a web server user whose user-id (`UID`) and groupd-id (`GID`) are `33`

So, replace `MY-GCS-BUCKET` with the name of your GCS bucket and you can run:

```
# Create the mount point in your local filesystem
sudo mkdir /mnt/MY-GCS-BUCKET

# Add an entry to your `fstab` to ensure the bucket is mounted even after reboot
sudo echo "MY-GCS-BUCKET /mnt/MY-GCS-BUCKET gcsfuse ro,uid=33,gid=33,noatime,_netdev,noexec,user,implicit_dirs,allow_other 0 0" >> /etc/fstab

# Mount the bucket
sudo mount /mnt/MY-GCS-BUCKET
```

### Explaining the mount options:

* `ro` - mount the volume in `read-only` mode
* `uid=33,gid=33` - grant access to user-id and group-id 33 (usually the web serve user e.g. `www-data`)
* `noatime` - don't update access times of files
* `_netdev` - mark this as a network volume so the OS knows that the network needs to be available before it'll try to mount
* `noexec` - don't allow execution of files in the mount
* `user` - allow non-root users to mount the volume
* `implicit_dirs` - treat object paths as if they were directories - this is critical and Fuse-specific
* `allow_other` - allow non-root users to mount (Fuse-specific AFAIK)

## Serving
You should now be able to configure your web server with a document root of the mount point (`/mnt/MY-GCS-BUCKET`) and you're done!