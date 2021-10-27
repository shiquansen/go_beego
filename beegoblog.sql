/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云mysql8
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : 47.108.27.128:3306
 Source Schema         : beegoblog

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 08/09/2021 19:55:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_usr_info
-- ----------------------------
DROP TABLE IF EXISTS `admin_usr_info`;
CREATE TABLE `admin_usr_info`  (
  `id` bigint unsigned NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `usr_id` bigint(0) NOT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `motto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `personal_info` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `personal_introduction` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_admin_usr_info_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_usr_info
-- ----------------------------
INSERT INTO `admin_usr_info` VALUES (1, '2020-10-26 23:39:22.700', '2020-11-01 19:56:16.580', NULL, 1, '※听雨※', '一名90后业余编程爱好者', '云南', '暂无', '一个没有故事的男同学，没什么介绍......');

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` bigint unsigned NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `title` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cid` bigint unsigned NOT NULL,
  `desc` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `page_view` bigint(0) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_article_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (1, '2020-09-13 21:49:06.000', '2021-09-02 23:15:46.122', NULL, 'HTML5 视频流行插件之video.js', 7, 'HTML5 视频流行插件之video.js', '[https://www.cnblogs.com/chenyingying0/p/12422727.html](https://www.cnblogs.com/chenyingying0/p/12422727.html)', 17);
INSERT INTO `article` VALUES (2, '2020-10-08 16:49:00.000', '2021-09-03 04:21:10.491', NULL, 'EF Core更新表中某一个字段的值', 1, 'EF Core更新表中某一个字段的值', '```csharp\n/// <summary>\n/// 更新浏览次数\n/// </summary>\npublic void UpdateViews(Article article)\n{\n    _context.Articles.Attach(article);\n    article.Views += 1;\n    _context.SaveChanges();\n}\n```\n', 32);
INSERT INTO `article` VALUES (3, '2019-12-14 20:50:38.000', '2021-09-01 19:28:31.344', NULL, 'C#动态创建控件并绑定事件', 1, 'C#动态创建控件并绑定事件', '## C#动态创建控件并绑定事件\n\n```csharp\nprivate void Form1_Load(object sender, EventArgs e)\n{\n    for (int i = 0; i < 5; i++)\n    {\n        Button btn = new Button();   //创建对象\n        btn.Size = new Size(100, 25);   //大小\n        btn.Text = (i + 1).ToString();        //文本\n        btn.Location = new Point(i*120,12);     //位置\n        btn.Click += new EventHandler(Btn_Click);   //委托事件，绑定全部按钮点击事件\n        btn.MouseClick += new MouseEventHandler(Btn_MouseClick);    ////委托事件，绑定全部按钮鼠标点击事件\n        this.Controls.Add(btn);     //添加到窗体\n    }\n}\n\npublic void Btn_Click(object sender, EventArgs e)\n{\n    Button btn = (Button)sender;    //获取所点击的对应的button\n    MessageBox.Show(btn.Text);\n}\n\npublic void Btn_MouseClick(object sender, MouseEventArgs e)\n{\n    Button btn = (Button)sender;    //获取所点击的对应的button\n    if (e.Button == MouseButtons.Right)\n    {\n        //右键需执行代码\n        \n    }\n}\n```\n', 46);
INSERT INTO `article` VALUES (4, '2020-10-15 20:55:25.769', '2021-09-03 08:13:45.248', NULL, 'elementary os安装后配置', 2, 'elementary os安装后配置', '# elementary os安装后配置\n参考链接  https://www.jianshu.com/p/f0298125ad84/\n\n*2020年10月25日 更新博客*\n\n*注意：本人使用最新的 elementaryos-5.1-stable.20200814.iso，貌似安装deepin-wine有问题，导致开机黑屏，大家自行测试。*\n\n\n## 一、换源\n不换源！不用换源！不要换源！\n\n\n## 二、安装elementary-tweaks\n\n```bash\nsudo add-apt-repository ppa:philip.scott/elementary-tweaks\nsudo apt update\nsudo apt install elementary-tweaks\n```\n\n## 三、安装 wingpanel-indicator-ayatana 第三方应用状态栏图标修复\n\n1. weget下载安装\n\n```bash\nwget http://ppa.launchpad.net/elementary-os/stable/ubuntu/pool/main/w/wingpanel-indicator-ayatana/wingpanel-indicator-ayatana_2.0.3+r27+pkg17~ubuntu0.4.1.1_amd64.deb\n\nsudo dpkg -i wingpanel-indicator-ayatana_2.0.3+r27+pkg17~ubuntu0.4.1.1_amd64.deb\n```\n\n2. 网盘下载到本地安装\n下面提供 deb的安装包，重启\n  链接：[https://share.weiyun.com/5ecLBmv](https://share.weiyun.com/5ecLBmv) 密码：htg5kj\n\n\n## 四、安装搜狗输入法\n1. 卸载 ibus\n\n```bash\nsudo apt remove ibus  scim\nsudo apt autoremove\n```\n2. 安装 Eddy 软件包安装器\n![安装eddy](https://img-blog.csdnimg.cn/20191209215804240.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIxNDI0Mw==,size_16,color_FFFFFF,t_70)\n\n3. 安装搜狗输入法\n\n下载搜狗输入法deb包，链接 https://pinyin.sogou.com/linux/  ，使用 Eddy 安装器安装搜狗输入法deb包（自动安装相关依赖）\n\n4. 设置默认\n\n```bash\nsudo im-config -s fcitx -z default\n```\n5. 重启下，或注销重新登录，看看现在应该可以使用了。\n\n\n\n## 五、安装字体\n建议安装下 **微软雅黑、宋体、新宋体**\n![安装字体](https://img-blog.csdnimg.cn/20191209221119910.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIxNDI0Mw==,size_16,color_FFFFFF,t_70)\n\n\n## 六、安装 desktop folder 桌面管理软件\n![desktop folder](https://img-blog.csdnimg.cn/20191209221416529.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIxNDI0Mw==,size_16,color_FFFFFF,t_70)\n安装后运行下，桌面就可以放图标了\n\n## 七、其他软件安装\n安装  360浏览器（链接：https://mirrors.huaweicloud.com/deepin/pool/non-free/b/browser360-cn-stable/ ）、谷歌浏览器、火狐浏览器、网易云音乐（链接：http://d1.music.126.net/dmusic/netease-cloud-music_1.2.1_amd64_ubuntu_20190428.deb ）、QQ、微信、任务管理器等等。\nQQ 、 微信、钉钉 可以到  \n\n> 优麒麟官网 （链接 ：https://www.ubuntukylin.com/applications/）\n>麒麟软件官网（链接： http://www.kylinos.cn/adaptation/application.html）\n> ------另QQ官方原生Linux版已更新只第二版，自行下载安装，链接：https://im.qq.com/linuxqq/download.html\n\n 的软件下载区下载，使用 Eddy安装即可。\n\n\n## 八、关于elementary os网易云音乐托盘图标不显示菜单解决方法\n转载至：https://www.cnblogs.com/dudujerry/p/10152326.html\n\n1. 将 `/etc/xdg/autostart/indicator-application.desktop` 中的\n\n```bash\nOnlyShowIn=Unity;GNOME;\n```\n\n修改为\n\n```bash\nOnlyShowIn=Unity;GNOME;Pantheon;\n```\n\n\n2. 修改网易云音乐的.desktop\n找到网易云音乐的.desktop，编辑（随便选一种吧）：\n\n```bash\nsudo nano /usr/share/applications/netease-cloud-music.desktop\nsudo io.elementary.code /usr/share/applications/netease-cloud-music.desktop\nsudo gedit /usr/share/applications/netease-cloud-music.desktop\n```\n\n将\n\n```bash\nExec=netease-cloud-music %U\n```\n\n修改为\n\n```bash\nExec=env XDG_CURRENT_DESKTOP=Unity netease-cloud-music %U\n```\n\n保存退出这样就可以用了。\n\n\n\n## 九、关于 deepin-wine qq/tim 无法接收图片解决方法\nhttps://bbs.deepin.org/forum.php?mod=viewthread&tid=189805&extra=page%3D1\n\n\n## 十、关于独显驱动的安装\n一般在应用商店会有独显驱动推荐，安装即可。\n应用商店==>更新--> \n例如，英伟达的  NVIDIA-drive-390    点击后面安装、免费、...（翻译可能有点问题）', 81);
INSERT INTO `article` VALUES (5, '2020-10-25 21:32:57.318', '2021-09-03 06:21:10.695', NULL, 'manjaro、Arco Linux安装后简单配置', 2, 'manjaro、Arco Linux安装后简单配置', '# manjaro、Arco Linux安装后简单配置\n\n## 0 安装问题\n在安装过程中会卡住进不去安装预览界面，多数是因为独显的缘故。可以在启动配置界面选中 BOOT*** 这一项，按键盘 E 键进入编辑模式，找到 quiet ，在后面加上 nouveau.modeset=0 ，按 F10保存，一般就能进入安装预览界面进行安装了。\n\n\n## 1 首先 联网\n有WiFi的可以直接找到自己WiFi连接就行（有的WiFi为中文的可能乱码或者连接失败，可以换成英文试试）。使用网线进行有线连接的插上网线，右击右下角网络图标 进入编辑连接，找到IPV4，改为手动，输入自己IP地址、网关、DNS等 确认后一般就能连接成功。\n\n## 2 更换源\n1. manjaro 可在终端 执行 \n```shell\nsudo pacman-mirrors -i -c China -m rank\n```\n，在弹出窗口选择你中意的源，之后再执行 \n```shell\nsudo pacman -Syy\n```\n刷新源即可\n\n2. 或者编辑 mirrorlist、pacman.conf，执行\n```shell\nsudo nano /etc/pacman.d/mirrorlist\n```\n 在最上方添加两行源地址\n\n```shell\n## 阿里云\nServer = http://mirrors.aliyun.com/archlinux/$repo/os/$arch\n## 清华大学\nServer = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch\n```\n编辑好文本后按trl + x 然后按y再按回车退出。\n执行\n```shell\nsudo nano /etc/pacman.conf\n```\n 在最下方添加：\n ```shell\n  [archlinuxcn]\n  server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch\n```\n退出后执行\n```shell\nsudo pacman -Syy\n```\n刷新源\n\n3. Arco Linux使用 2的方法\n\n\n## 3 安装软件\n1. 安装输入法  谷歌拼音\n```shell\nsudo pacman -S fcitx-googlepinyin\nsudo pacman -S fcitx-im \nsudo pacman -S fcitx-configtool\n```\n编辑~/.xprofile\n```shell\nsudo nano ~/.xprofile\n输入\nexport gtk_im_module=fcitx\nexport qt_im_module=fcitx\nexport xmodifiers=\"@im=fcitx\"\n```\n保存退出即可\n\n2. 其他软件使用  sudo pacman -S 软件名方式安装即可，例如\n ```shell\nsudo pacman -S deepin-terminal\n```\n\n## 4  安装独显驱动\n1. 打开所有设置（开始菜单-->设置）\n找到 manjaro 驱动管理，打开即可选择安装驱动，推进安装闭源驱动\n2.  不想使用独显使用核显的 可以编辑 grub，执行\n```shell\nsudo pacman -S xed   //安装xed文本编辑器，或使用其他\nsudo xed /boot/grub/grub.cfg\nctrl + f 搜索 quiet 在搜索到的第一个后加上\nnouveau.modeset=0\nctrl + s 保存，关闭\n```\n\n## 5 其他待补充', 13);
INSERT INTO `article` VALUES (6, '2020-10-25 21:34:24.692', '2021-09-02 22:38:15.459', NULL, 'Asp.Net Core报错：System.Text.Json.JsonException: A possible object cycle was detected which is not supported', 1, 'Asp.Net Core报错：System.Text.Json.JsonException: A possible object cycle was detected which is not supported', 'Asp.Net Core报错：System.Text.Json.JsonException: A possible object cycle was detected which is not supported. This can either be due to a cycle or if the object depth is larger than the maximum allowed depth of 32\n\n检测到不支持的可能对象循环。这可能是由于周期或物体深度大于最大允许深度32。\n\n这是由于进行了对象嵌套或ef 查询进行了预加载（关联加载）引起的，就像解释说的“对象循环”，层级太深解析不了。\n\n解决方法：\n1. 添加 Microsoft.AspNetCore.Mvc.NewtonsoftJson 包\n2. Startup中添加服务，忽略循环引用\n\n```csharp\nservices.AddControllers().AddNewtonsoftJson(option =>\n                //忽略循环引用\n                option.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore\n            );\n```\n或者 \n通过另外创建一个类对查询到的数据进行封装后再返还。\n\n\n', 16);
INSERT INTO `article` VALUES (7, '2020-10-25 21:36:04.203', '2021-09-02 08:15:55.948', NULL, '.net core中修改cshtml代码不用重启项目的方法', 1, '.net core中修改cshtml代码不用重启项目的方法', '## 1. 添加Nuget包\n安装 Microsoft.AspNetCore.Mvc.Razor.RuntimeCompilation 包\n\n## 2. 配置服务\nstratup的ConfigureServices中添加\n```csharp\nservices.AddRazorPages().AddRazorRuntimeCompilation();  //添加运行时编译功能\n```', 22);
INSERT INTO `article` VALUES (8, '2020-10-25 21:37:23.484', '2021-09-02 08:11:13.314', NULL, 'webbrowser内核指定', 1, 'webbrowser内核指定', '1. 手动指定webbrowser内核\n找到注册表项：HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Internet Explorer\\MAIN\\FeatureControl\\FEATURE_BROWSER_EMULATION\n\n在右侧空白区域内单击鼠标右键，点击[新建]→[DWORD（32-位）值]，新建的项取名为MyApplication.exe（程序名），编辑值时，选择基数“十进制”，填写数值数据，这里填写11000（IE11）。最后运行MyAplication.exe，此时MyAplication.exe的webbrowser内核已指定为IE11。\n![不同IE版本所对应的DWORD值：](https://img-blog.csdnimg.cn/20191209083324564.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDIxNDI0Mw==,size_16,color_FFFFFF,t_70)\n2. 使用代码指定WebBrowser内核\n\n```csharp\npublic class IEVersion\n  {\n      /// <summary>\n      /// IE WebBrowser内核设置\n      /// </summary>\n      public static void BrowserEmulationSet()\n      {\n          //当前程序名称\n          var exeName = Process.GetCurrentProcess().ProcessName + \".exe\";\n          //系统注册表信息\n          var mreg = Registry.LocalMachine;\n          //IE注册表信息\n          var ie = mreg.OpenSubKey(@\"SOFTWARE\\Microsoft\\Internet Explorer\\MAIN\\FeatureControl\\FEATURE_BROWSER_EMULATION\", RegistryKeyPermissionCheck.ReadWriteSubTree);\n          if (ie != null)\n          {\n              try\n              {\n                  var val = ieVersionEmulation(ieVersion());\n                  if (val != 0)\n                  {\n                      ie.SetValue(exeName, val);\n                  }\n                  mreg.Close();\n              }\n              catch (Exception ex)\n              {\n                  Console.Write(ex.Message);\n              }\n          }\n      }\n \n      /// <summary>\n      /// IE版本号\n      /// </summary>\n      /// <returns></returns>\n      static int ieVersion()\n      {\n          //IE版本号\n          RegistryKey mreg = Registry.LocalMachine;\n          mreg = mreg.CreateSubKey(\"SOFTWARE\\\\Microsoft\\\\Internet Explorer\");\n \n          //更新版本\n          var svcVersion = mreg.GetValue(\"svcVersion\");\n          if (svcVersion != null)\n          {\n              mreg.Close();\n              var v = svcVersion.ToString().Split(\'.\')[0];\n              return int.Parse(v);\n          }\n          else\n          {\n              //默认版本\n              var ieVersion = mreg.GetValue(\"Version\");\n              mreg.Close();\n              if (ieVersion != null)\n              {\n                  var v = ieVersion.ToString().Split(\'.\')[0];\n                  return int.Parse(v);\n              }\n          }\n          return 0;\n      }\n \n      /// <summary>\n      /// 根据IE版本号 返回Emulation值\n      /// </summary>\n      /// <param name=\"ieVersion\"></param>\n      /// <returns></returns>\n      static int ieVersionEmulation(int ieVersion)\n      {\n          //IE7 7000 (0x1B58)\n          if (ieVersion < 8)\n          {\n              return 0;\n          }\n          if (ieVersion == 8)\n          {\n              return 0x1F40;//8000 (0x1F40)、8888 (0x22B8)\n          }\n          if (ieVersion == 9)\n          {\n              return 0x2328;//9000 (0x2328)、9999 (0x270F)\n          }\n          else if (ieVersion == 10)\n          {\n              return 0x02710;//10000 (0x02710)、10001 (0x2711)\n          }\n          else if (ieVersion == 11)\n          {\n              return 0x2AF8;//11000 (0x2AF8)、11001 (0x2AF9\n          }\n          return 0;\n      }\n  }\n```\n最后，在程序启动时调用即可：\n\n```csharp\nIEVersion.BrowserEmulationSet();\n```\n', 13);
INSERT INTO `article` VALUES (14, '2020-12-11 20:50:56.539', '2021-09-02 08:20:56.886', NULL, 'ThinkPHP5.1对枚举类型字段进行order排序bug问题', 3, 'ThinkPHP5.1对枚举类型字段进行order排序desc和asc相反', '解决方法：  \n1. 不要使用枚举  \n2. 调换枚举顺序0放在最前面', 28);
INSERT INTO `article` VALUES (15, '2021-08-10 23:05:11.340', '2021-09-02 01:52:39.579', NULL, 'Rust中结构体的方法与其关联函数', 12, 'Rust中结构体的方法与其关联函数', '1. 方法定义 \n ```\n	impl 结构体名称 {\n		fn 方法名($self, 参数){}\n	}\n\n```\n\n2. 关联函数定义\n\n```\n	impl 结构体名称{\n		fn 函数名(参数)->返回值{\n        		//函数体\n    		}\n	}\n\n```\n', 10);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint unsigned NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 'C#');
INSERT INTO `category` VALUES (2, 'Linux');
INSERT INTO `category` VALUES (3, 'PHP');
INSERT INTO `category` VALUES (4, 'Java');
INSERT INTO `category` VALUES (5, 'Golang');
INSERT INTO `category` VALUES (6, 'windows');
INSERT INTO `category` VALUES (7, '前端');
INSERT INTO `category` VALUES (8, '易语言');
INSERT INTO `category` VALUES (10, '闲言碎语');
INSERT INTO `category` VALUES (11, '资源分享');
INSERT INTO `category` VALUES (12, 'Rust');

-- ----------------------------
-- Table structure for friendly_link
-- ----------------------------
DROP TABLE IF EXISTS `friendly_link`;
CREATE TABLE `friendly_link`  (
  `id` bigint unsigned NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `linkname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `domain_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_friendly_link_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of friendly_link
-- ----------------------------
INSERT INTO `friendly_link` VALUES (1, '2020-10-25 20:52:55.000', '2020-10-25 20:52:58.000', NULL, 'layui', 'https://www.layui.com', 'layui.com');
INSERT INTO `friendly_link` VALUES (2, '2020-10-25 20:58:44.000', '2020-10-25 20:58:47.000', NULL, '码云', 'https://gitee.com', 'gitee.com');
INSERT INTO `friendly_link` VALUES (3, '2020-10-25 20:59:36.000', '2020-10-25 20:59:39.000', NULL, 'bootstrap', 'https://v4.bootcss.com', 'bootcss.com');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint unsigned NOT NULL,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` bigint(0) DEFAULT 2,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_deleted_at`(`deleted_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '2020-10-26 23:10:56.000', '2020-11-01 15:25:02.966', NULL, 'tingyu', 'VbNKsZNV/i4=', 1);

SET FOREIGN_KEY_CHECKS = 1;
