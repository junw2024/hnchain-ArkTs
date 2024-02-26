import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
import mediaBreakpoint  from '../../common/utils/MediaBreakpoint'
import { LoginView } from '../../view/login/LoginView'
import { PrivacyStatement } from '../../view/login/PrivacyStatementView'
import barManager from '../../common/utils/WindowManager'
@Entry
@Component
struct LoginPage {
  //状态栏高度
  @State  topHeight:number= barManager.getInstance().getSystemBarOffset()
  aboutToAppear(){
    mediaBreakpoint.register();
  }
  aboutToDisappear(){
    mediaBreakpoint.unRegister();
  }

  @Builder Title(){
    Row(){
      Image($r('app.media.login_ic_back'))
        .width($r('app.float.image_size'))
        .height($r('app.float.image_size'))
        .margin({
          left: $r('app.float.image_margin_left'),
          right: $r('app.float.image_margin_right')
        })
        .onClick(()=>{
          router.back()
        })
      Text($r('app.string.hnchain_login_title'))
        .fontSize($r('app.float.title_text_size'))
        .fontColor($r('app.color.title'))
        .fontWeight(500)

    }
    .width(CommonConstants.FULL_SIZE)
    .height($r('app.float.title_height'))
  }
  build(){
    Column(){
      this.Title()
      Scroll(){
        Column(){
          LoginView()
          Blank()
          PrivacyStatement()
        }
        .height(CommonConstants.FULL_PERCENT)
        .constraintSize({ minHeight: $r('app.float.scroll_min_height') })
        .alignItems(HorizontalAlign.Start)
        .padding($r('app.float.login_operation_area_padding'))
      }
      .layoutWeight(1)
    }
    .width(CommonConstants.FULL_SIZE)
    .margin({top: px2vp(this.topHeight+12)})
  }
}