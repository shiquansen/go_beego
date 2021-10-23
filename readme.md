### 学习go专用
 - ### 安装（参考 https://www.jianshu.com/p/1961ad9f65e9 ）
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
    
  - ### 代码爆红解决（参考：https://blog.csdn.net/myqq1418/article/details/118527023）
    1. 问题描述：`$GOPATH/go.mod exists but should not`
    2. 问题解决：setting -> go -> goPath -> 删除`Project GoPath` 以及 `Module GoPath`问题解决
  - ### Mod
    1. 实际上就是go项目的依赖管理工具
  - ### 设置全局变量
       ```    
       go env -w GOBIN=/Users/youdi/go/bin
       go env -w GO111MODULE=on
       go env -w GOPROXY=https://goproxy.cn,direct // 使用七牛云的
       //go env -w会将配置写到 GOENV="/Users/youdi/Library/Application Support/go/env"
       ```     