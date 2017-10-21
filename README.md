

## One Android Devices mapping to One Docker Container using udev and cgroup

* host udev rule setup

```
cp ./bin/* /usr/bin
cp -f 99-detect.rules  /etc/udev/rules.d/
service udev restart
udevadm trigger
```

* android_udev_stf_container image build

```
docker build -t nuaays/android_stf .
```

* simple docker image only with adb

```
nuaays/android_stf:adb
```

* docker image with stf and rethinkdb

```
nuaays/android_stf:stf
```
