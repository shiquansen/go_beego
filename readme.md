### 学习go专用
 - #### 安装（参考 https://www.jianshu.com/p/1961ad9f65e9 ） 2021-10-25
   1. 由于很多包在github上面，使用国内镜像代理方便
        ```cassandraql
      go env -w GO111MODULE=on
      go env -w GOPROXY=https://goproxy.cn,direct
   2. 安装 `beego` `bee`
        ```cassandraql
        go get -u github.com/astaxie/beego  (-u:update)
      go get github.com/beego/bee
    3. 将bee所在的bin放入系统变量
    4. 新建src，进入src
    5. 运行 `bee new projectName`
    6. 执行 `bee run` 访问到 `http://localhost:8080` 成功
    
  - #### 代码爆红解决（参考：https://blog.csdn.net/myqq1418/article/details/118527023）  2021-10-26
    1. 问题描述：`$GOPATH/go.mod exists but should not`
    2. 问题解决：setting -> go -> goPath -> 删除`Project GoPath` 以及 `Module GoPath`问题解决
  - #### Mod
    1. 实际上就是go项目的依赖管理工具
  - #### 设置全局变量
       ```    
       go env -w GOBIN=/Users/youdi/go/bin
       go env -w GO111MODULE=on
       go env -w GOPROXY=https://goproxy.cn,direct // 使用七牛云的
       //go env -w会将配置写到 GOENV="/Users/youdi/Library/Application Support/go/env"
       ```     
  - #### 调试篇 2021-10-28
    - 因为不知道源代码怎么进行下去，所以直接debug但是发现，调试的exe太老
    ```
    Version of Delve is too old for this version of Go (maximum supported version 1.12, suppress this error with --check-go-version=false)  
    ```
    对dlv升级      `go get -u github.com/go-delve/delve/cmd/dlv`,重新运行,发现调试器在idea的目录下，替换idea的dlv.exe,再次运行
    ```cassandraql
    GOROOT=C:\Go #gosetup
    GOPATH=C:\Users\samle\go #gosetup
    C:\Go\bin\go.exe build -o C:\Users\samle\AppData\Local\Temp\___1go_build_main_go.exe -gcflags "all=-N -l" C:\Users\samle\go\src\beegoblog\main.go #gosetup
    "E:\install\GoLand 2019.2.3\plugins\go\lib\dlv\windows\dlv.exe" --listen=localhost:4011 --headless=true --api-version=2 exec C:\Users\samle\AppData\Local\Temp\___1go_build_main_go.exe -- #gosetup
    ```
    运行再次发现go版本过老，直接升级go
    ```
    Version of Go is too old for this version of Delve (minimum supported version 1.15, suppress this error with --check-go-version=false)        ```
    ```
    去官网`https://golang.google.cn/dl/ `找到最新的zip`go1.17.2.windows-amd64.zip`解压,删除原来的go，复制进去，debug成功。
    