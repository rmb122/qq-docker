# qq-docker

容器化的新版本 electron QQ.  

## 运行

```
# 生成构建镜像需要的环境变量
./init.sh

# 启动容器, 会自动打开 QQ
docker-compose up -d
```

在当前目录下会生成两个文件夹, QQ 和 shared 文件夹. 其中 QQ 文件夹挂载在 /home/user/.config/QQ 中, 为 QQ 的聊天记录等内容. 而 shared 文件夹其被挂载在容器的 /home/user/shared 中, 可以通过此文件夹进行文件共享.

需要注意的是, 目前输入法只支持 fcitx5. 同时如果需要播放声音, 则可能需要依赖 pulseaudio, 在这种情况下你需要在宿主机上安装 pulseaudio 或者兼容层 (例如: pipewire-pulse)

另外, 第一次启动时 QQ 会尝试进行同步消息, 需要花费较多时间, 耐心等待即可, 不是 QQ 崩溃了.

## 目前存在的问题

1. 客户端仍然在内测当中, 需要内测资格.
2. 截图功能不正常, 实现在 /opt/QQ/resources/app/screencast.gjs, 通过 dbus 调用 org.gnome.Shell.Screencast 来截图. 目前可以通过在宿主机上截图, 通过剪贴板粘贴来 workaround.
3. 输入法在粘贴图片后小概率失效, 无法稳定复现. 可以通过切换聊天窗口来恢复. 类似的还有在输入法中输入 `session` 可以稳定触发 bug.
4. 只在 archlinux + i3wm 上进行过测试.
5. 无法拖动传文件, 未来可以通过软链接容器内 shared 文件夹到一个与宿主机 shared 文件夹路径相同的文件夹来解决.
6. QQ 邮箱无法打开, 之后可以考虑自己实现一个 xdg-open, 将目标 url 带出来.

## 免责提示

由于 X Server 的特殊性, 即使使用 Docker 也不能做到完全阻止所有攻击面. 虽然概率极低, 但是攻击者 (e.g. 腾讯), 完全可以在容器内达到类似[按键记录器](https://wiki.archlinux.org/title/Bubblewrap#Using_X11:~:text=While%20bwrap%20provides,a%20wayland%20compositor.)的效果. 因此如果你对腾讯非常介意, 请勿使用本项目, 可以选择使用虚拟机启动 QQ. 另外, 也不要在容器内运行任何不信任的代码.
