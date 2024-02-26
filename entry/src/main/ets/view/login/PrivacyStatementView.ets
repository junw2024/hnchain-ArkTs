
import router from '@ohos.router'
import { CommonConstants } from '../../common/constants/CommonConstants'
@Component
export struct  PrivacyStatement  {
  build(){
    GridRow({
      columns:{
        sm:4,
        md:8,
        lg:12
      },
      gutter:{x:12},
      breakpoints:{value:['320vp', '600vp', '820vp']}
    }){
      GridCol({
        span:{
          sm:2,
          md:4,
          lg:4
        },
        offset:{
          sm:1,
          md:2,
          lg:4
        }
      }){
        Flex({
          direction: FlexDirection.Row,
          justifyContent: FlexAlign.SpaceBetween
        }){
          Text($r('app.string.problem_encountered'))
            .fontSize($r('app.float.statement_text_size'))
            .fontColor($r('app.color.problem_encountered_font'))
            .textAlign(TextAlign.Center)
            .onClick(() => {
              router.pushUrl({
                url: ""
              });
            })

          Text($r('app.string.privacy_statement'))
            .fontSize($r('app.float.statement_text_size'))
            .fontColor($r('app.color.privacy_statement_font'))
            .textAlign(TextAlign.Center)
            .onClick(() => {
              router.pushUrl({
                url: ""
              });
            })
        }
        .width(CommonConstants.FULL_PERCENT)
        .margin({
          bottom: $r('app.float.statement_area_margin_bottom')
        })
      }
    }
    .margin({
      left: $r('app.float.gird_row_margin_left'),
      right: $r('app.float.gird_row_margin_right')
    })
  }
}