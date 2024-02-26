# 电商系统（ArkTS）

### 简介
基于自适应和响应式布局，实现一次开发，多端部署的购物应用，
后台go-zero微服务架构实现：api(网关)、order、product、user、reply等服务

1. 分别在手机、折叠屏、平板安装并打开应用，不同设备的应用页面通过响应式布局和自适应布局呈现不同的效果。
2. 点击底部首页、新品、购物车、我的图片文字按钮，切换显示对应的标签页，默认显示首页标签页。
3. 点击首页标签页或购物车标签页的商品列表，跳转到商品详情页。
4. 点击商品详情页的立即购买按钮，跳转到订单确认页。
5. 点击订单确认页的提交订单，跳转到订单支付页。
6. 点击我的标签页的我的订单栏的按钮，跳转到订单列表页。
7. 其他按钮无实际点击事件或功能。

### 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机或运行在DevEco Studio上的华为手机设备模拟器。
2. 本示例为Stage模型，支持API version 9。
3. 本示例需要使用DevEco Studio 3.1 Release版本进行编译运行。