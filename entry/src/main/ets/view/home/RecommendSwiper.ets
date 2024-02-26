
import BreakpointConstants from '../../common/constants/BreakpointConstants'
import { CommonConstants } from '../../common/constants/CommonConstants'
import { Product } from '../../model/Product'
import { Recommend } from '../../model/Recommend'
import homeService from '../../service/HomeService'
@Component
export struct RecommendSwiper {
  @StorageProp('currentBreakpoint') curBreakpoint: string = BreakpointConstants.BREAKPOINT_SM;
  @State products: Product[] =[]    //推荐商品
  private  param: Recommend= new Recommend(0,0,10,false) //请求参数
  aboutToAppear(){
    if(!this.param.isEnd){
      homeService.getRecommendPage(this.param)
        .then((data)=>{
          if(!data.isEmpty()){
            this.products = data.convertToArray()
          }
        })
    }
  }
  build(){
    Swiper(){
      ForEach(this.products,(item: Product)=>{
        Image(item.imageurl)
          .width(CommonConstants.FULL_WIDTH)
          .aspectRatio(CommonConstants.IMAGE_ASPECT_RATIO)
          .borderRadius($r('app.float.vp_sixteen'))
          .backgroundColor(Color.White)
      },(item: Product)=> item.id.toString())
    }
    .indicatorStyle({selectedColor: $r('app.color.indicator_select')})
    .autoPlay(true)
    .itemSpace(this.curBreakpoint === BreakpointConstants.BREAKPOINT_SM? "0vp": CommonConstants.VP_FOURTEEN)
    .width(CommonConstants.FULL_WIDTH)
    .indicator(this.curBreakpoint === BreakpointConstants.BREAKPOINT_SM)
    .displayCount(this.curBreakpoint === BreakpointConstants.BREAKPOINT_LG? 3 : (this.curBreakpoint === BreakpointConstants.BREAKPOINT_MD? 2 :1))
    .margin({top:$r('app.float.vp_twelve'),bottom:$r('app.float.vp_twelve')})
  }
}