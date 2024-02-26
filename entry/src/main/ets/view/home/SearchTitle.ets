import { CommonConstants } from '../../common/constants/CommonConstants'
import { searchSwiperData } from '../../modelview/HomeDataModel'

@Component
export struct SearchTitle{
  build(){
    Column(){
      Flex({justifyContent: FlexAlign.SpaceBetween}){
        Image($r('app.media.ic_eshop'))
          .height(CommonConstants.FULL_HEIGHT)
          .aspectRatio(1)
        Image($r('app.media.ic_scan'))
          .height(CommonConstants.FULL_HEIGHT)
          .aspectRatio(1)

      }
      .width(CommonConstants.FULL_WIDTH)
      .height($r('app.float.vp_twenty_four'))
      .margin({bottom: $r('app.float.vp_eight')})
      Row(){
        Image($r('app.media.ic_search'))
          .height($r('app.float.vp_twenty'))
          .width($r('app.float.vp_twenty'))

        Swiper(){
          ForEach(searchSwiperData,(it: string)=>{
            Column(){
              Text(it)
                .fontSize($r('app.float.smaller_font_size'))
                .fontColor(Color.Black)
            }
            .alignItems(HorizontalAlign.Start)

          },(it: string)=> it)

        }
        .loop(true)
        .autoPlay(true)
        .vertical(true)
        .indicator(false)

      }
      .height($r('app.float.search_swiper_height'))
      .width(CommonConstants.FULL_WIDTH)
      .borderRadius($r('app.float.vp_twenty'))
      .backgroundColor(Color.White)
    }
    .width(CommonConstants.FULL_WIDTH)
    .padding({top:$r('app.float.vp_twelve'),bottom:$r('app.float.vp_twelve')})
    .backgroundColor(Color.Red)
  }
}