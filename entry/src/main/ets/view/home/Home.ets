import { CommonConstants } from '../../common/constants/CommonConstants'
import { ProductPageParam } from '../../model/ProductPageParam'
import { activityTitles,ActivityTitle } from '../../modelview/HomeDataModel'
import { ProductList } from '../common/ProductList'
import { ClassTitle } from './ClassTitle'
import { RecommendSwiper } from './RecommendSwiper'
import { SearchTitle } from './SearchTitle'

@Entry
@Component
export struct Home {
  @State activityIndex: number=0


  @Builder ActivityTitle(){
    Flex({justifyContent:FlexAlign.SpaceAround}){
      ForEach(activityTitles,(it :ActivityTitle,index?:number)=>{
        Flex({
          direction: FlexDirection.Column,
          justifyContent: FlexAlign.Center,
          alignItems: ItemAlign.Center
        }) {
          Text(it.title)
            .fontWeight(CommonConstants.FONT_WEIGHT_FIVE)
            .fontSize($r('app.float.small_font_size'))
            .fontColor(Color.Black)
          Text(it.desc)
            .fontWeight(CommonConstants.FONT_WEIGHT_FOUR)
            .fontSize($r('app.float.smaller_font_size'))
            .opacity(this.activityIndex === index ? CommonConstants.FULL_OPACITY : CommonConstants.SIXTY_OPACITY)
            .fontColor(this.activityIndex === index ? $r('app.color.focus_color') : Color.Black)
        }
        .onClick(()=>{
          if (index !== undefined) {
            this.activityIndex = index;
          }
        })
        .height(CommonConstants.FULL_HEIGHT)
      },(it: ActivityTitle) => it.title.toString())
    }
    .height($r('app.float.activity_title_height'))
    .width(CommonConstants.FULL_WIDTH)
    .padding($r('app.float.vp_twelve'))
    .margin({ bottom: $r('app.float.vp_six'), top: $r('app.float.vp_six') })
    .backgroundColor($r('app.color.page_background'))
    .borderRadius($r('app.float.vp_sixteen'))
  }

  build(){
    Stack({alignContent: Alignment.Top}){
      Image($r('app.media.ic_app_background'))
        .width(CommonConstants.FULL_WIDTH)
        .height($r('app.float.image_background_height'))
        .objectFit(ImageFit.Auto)
      Flex({direction: FlexDirection.Column}){
        SearchTitle()
        Scroll(){
          Column(){
            ClassTitle()
            RecommendSwiper()
            this.ActivityTitle()
            if(this.activityIndex === 0){
              ProductList({ colnum:2, paramPage: new ProductPageParam(10,8,this.activityIndex) })
            }else if(this.activityIndex === 1){
              ProductList({ colnum:2, paramPage: new ProductPageParam(10,1,this.activityIndex) })
            }else if(this.activityIndex === 2){
              ProductList({ colnum:2, paramPage: new ProductPageParam(10,6,this.activityIndex) })
            }else if(this.activityIndex === 3 ){
              ProductList({ colnum:2, paramPage: new ProductPageParam(10,2,this.activityIndex) })
            }
          }
        }.scrollBar(BarState.Off)
      }
      .padding({ left: $r('app.float.vp_twelve'), right: $r('app.float.vp_twelve') })
    }
  }
}