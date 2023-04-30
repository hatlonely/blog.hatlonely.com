# blog.hatlonely.com

hatlonely 的个人小站

## ops 命令

1. 镜像制作

```shell
ops --variable .cfg/blog.yaml -a run --task image
ops --variable .cfg/blog.yaml -a run --task helm --cmd=diff
```