
import BreakpointConstants from '../common/constants/BreakpointConstants';
import { CommonConstants } from '../common/constants/CommonConstants';
import { ButtonInfoModel,buttonInfoArray } from '../modelview/ButtonInfoModel';
import { Cart } from '../view/cart/Cart';
import { Home } from '../view/home/Home';
import { Mine } from '../view/mine/Mine';
import { Product } from '../view/product/Product';
import mediaBreakpoint from '../common/utils/MediaBreakpoint'
import StorageDefParam from '../common/utils/StorageDefParam'
import windowManager from '../common/utils/WindowManager'
import Logger from '../common/utils/Logger';
import  loginService from  '../service/LoginService'
import router from '@ohos.router';


/**
 * 主页
 */
@Entry
@Component
struct  MainIndex {
  @StorageProp('currentBreakpoint') curBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;
  @StorageLink('indexPage') curIndexPage: number =0;
  //状态栏高度
  @State  topHeight:number= windowManager.getInstance().getSystemBarOffset()

  aboutToAppear(){
    AppStorage.Set<string>(BreakpointConstants.CURRENT_BREAKPOINT,"SM")
    mediaBreakpoint.register();
    StorageDefParam.setDefIndexPage();
    //禁止横屏
    let win =windowManager.getInstance();
    win.orientationPortrait().then(()=>{})
  }
  aboutToDisappear(){
    mediaBreakpoint.unRegister();
  }
  //显示页面
  onPageShow(){

  }

  build(){
    Column(){
      Tabs({
        barPosition: this.curBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start : BarPosition.End,
        index: this.curIndexPage
      }){
        TabContent(){
          Home()
        }
        .tabBar(this.BtnNavigation(buttonInfoArray[ButtonInfoModel.HOME_INDEX]))

        TabContent(){
          Product()
        }.tabBar(this.BtnNavigation(buttonInfoArray[ButtonInfoModel.PRODUCT_INDEX]))

        TabContent(){
          Cart()
        }.tabBar(this.BtnNavigation(buttonInfoArray[ButtonInfoModel.CART_INDEX]))

        TabContent(){
          Mine()
        }.tabBar(this.BtnNavigation(buttonInfoArray[ButtonInfoModel.MY_INDEX]))
      }
      .barWidth(this.curBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.float.bar_width')  : CommonConstants.FULL_WIDTH)
      .barHeight(this.curBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      CommonConstants.SIXTY_HEIGHT : $r('app.float.vp_fifty_six'))
      .vertical(this.curBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .scrollable(false)
      .onChange((index: number)=>{
        if(index === ButtonInfoModel.MY_INDEX){
          if(!loginService.isLogin()){
            router.pushUrl({
              url: "pages/login/LoginPage"
            })
            return;
          }
        }
        this.curIndexPage = index
      })
    }
    .backgroundColor($r('app.color.page_background'))
    .margin({top: px2vp(this.topHeight+12)})

  }

  @Builder BtnNavigation(btn: ButtonInfoModel) {
    Column({ space: CommonConstants.BTN_NAVIGATION_SPACE }) {
      Image(this.curIndexPage === btn.index ? btn.selectImg : btn.img)
        .objectFit(ImageFit.Contain)
        .width($r('app.float.main_image_size'))
        .height($r('app.float.main_image_size'))

      Text(btn.title)
        .fontColor(this.curIndexPage === btn.index ? $r('app.color.focus_color') : Color.Black)
        .opacity(this.curIndexPage === btn.index ? CommonConstants.FULL_OPACITY : CommonConstants.SIXTY_OPACITY)
        .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
        .textAlign(TextAlign.Center)
        .fontSize($r('app.float.micro_font_size'))
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)

  }

}