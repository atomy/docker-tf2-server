## Team Fortress 2 + Docker

Team Fortress 2 server

```
docker pull atomy/tf2
```

## Configure

see server.cfg

### TF2 auth stuff

```text
tf_server_identity_account_id 1337
tf_server_identity_token "TRLOLOL"
sv_setsteamaccount "K4K4K4K4"
```

#### tf_server_identity
acquire both tf_server_identity_account_id and tf_server_identity_token from using cl_gameserver_list within your tf2 client.
If you need to create one, checkout the other cl_gameserver commands (find gameserver)

#### Steam account
sv_setsteamaccount parameter can be acquired from: http://steamcommunity.com/dev/managegameservers

### Details:
By default image is build with enabled autoupdate feature (take a look at `tf.sh` file).
You can create new Dockerfile based on that image (FROM spiretf/docker-tf2-server) and customize it with plugins, configs, CMD and ENTRYPOINT instructions.


### Debug
``` shell
docker run -it -p 27015:27015/udp -e LOCAL_USER_ID=`id -u` -e LOCAL_GROUP_ID=`id -g` -v $(pwd)/server.cfg:/srv/tf2/Steam/tf/cfg/server.cfg atomy/tf2 /bin/bash
```

## Run
```shell
docker run -it -p 27015:27015/udp -e LOCAL_USER_ID=`id -u` -e LOCAL_GROUP_ID=`id -g` -v $(pwd)/server.cfg:/srv/tf2/Steam/tf/cfg/server.cfg -v $(pwd)/server.cfg:/srv/tf2/Steam/tf/cfg/autoexec.cfg atomy/tf2 ./startServer.sh +map cp_mossrock
```
