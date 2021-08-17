

# beU Delivery 项目说明

## 一、开发规范：

1. 应用中可以独立成页面【Navigator.push()】的 Widget 最好以 Page/Pager 为后缀，放置在 src/pages/ 目录下。【类似 Android 中的 Activity】

2. 需要对外公开的 Page 构造器不能有参数存在，参数的传递一律走 RouteSetting，调用则按命名路由方式，需在 app Module 中的 app_routes 中做拦截处理；且路由名称则需要注册到 common Module 中的 Routes 表中，尽可能避免直接使用字符串。

3. Page 页面的 State 最好继承自 ReactableState【可响应的】、RetryableState【内置重试机制】、RefreshableState【内置刷新机制】之一，具体按需要来定。【类似 Android BaseActivity】

4. ListView，GridView 的 Item Widget 最好以 Item 前缀，以 Widget 为后缀，且放置在 src/items/ 目录下。

5. 抽出的复用 Widget 最好以 Widget/Component 为后缀，放置在 src/widgets/ 目录下；如若是全局通用，则可考虑增加扩展点，形成独立的 Component Module，此类 Module 的命名模式为：xxx_component。

6. Module 中业务逻辑处理【网络，IO，计算等】部分应放置在 Actuator 层，具体目录为：src/actuator/，可继承 ReactActuator，RetryActuator，RefreshActuator 之一，和第 2 条中的三种 State 对应，且 Actuator 以泛型的方式和 State 形成依赖关系。【类似 Android MVP 】

7. 每个独立 Module 可酌情考虑对外公开的内容，最好在 lib 目录生成一个以 Module 名为名称的 dart 文件，在该文件中使用 export 导出对外公开的内容。

8. 应用中的所有 Module 理论上都可以单独运行，最好在 Module 的根目录创建一个 example 目录，内部存放用于单独调试此 Module 的 dart 文件，最好有一个 example.dart 文件作为单独运行入口，将 main 函数放置其中，然后在 Run 菜单中配置一个 Flutter 可执行单元。

9. 对于交互需求较强的 Widget/Component 最好提供一个 Controller 作为外部操作的入口，且 Controller 和 Widget 放置在不同的 dart 文件中。



## 二、项目结构描述：

### 1.Module 维度

1. beU Delivery 项目采用多模块模式组织，将项目按 Library 和 Business 分为两层；

2. origin 为最底层包，其中包括日志，工具类，全局配置等，是作为底层基础库的中转点存在，在此包中会依赖一些项目通用的三方库和自定义的工具集；

3. 在 origin 之上是三方库的扩展库和全局资源库，包括 request，transition，image_picker 等；

4. 和 App 结构类似，在扩展库之上的就是 common 包，它是所有通用库的集结，所有的通用库会在这个包中被依赖且对上层【业务】提供依赖；



### 2. Business 包维度
1. 业务层分层结构类似 MVC / MVP / MVVM -> MVA【Actuator 执行者】承接具体业务逻辑的处理;

2. Business 包不直接互相依赖，这样可确保业务块中高内聚，业务块之间低耦合；

3. 业务之间通讯使用 EventBus，同时，封装的 BusClient 在 Actuator 中提供了相应的方法进行订阅和回收。

4. 业务层 UI 页面的跳转使用 Flutter 的 Navigator 系统，对应需公开给其他业务调用的页面，使用命名路由跳转，包内则使用直接路由，其中 libs_translation 包扩展了侧滑返回过渡动画，如无特殊需要，在 app_routes 中统一配置为 rightToLeft 方式动画。



## 1. app
> app 包是项目的壳 Module，其中包含了：

1. HomePage 和 SplashPage；
2. app 内需要命名路由的拦截器配置；
3. app 给 app_preview 导出的 library 部分【Device Preview】

> app Module 作为壳，是项目打包，发布的主要 Module，其 android 和 ios 目录是经过特殊配置的，如对发布内容做调整可在此修改。


## 2. all_preview
> all_preview 是作为 Devices Preview 的上层壳，在 app 打包发布时不会对其产生影响；用于设备适配
> 
> 


# 部分类的创建模版

```

```

