
import ArrayList from '@ohos.util.ArrayList'
import { CommonConstants } from '../../common/constants/CommonConstants'
import Category from '../../model/Category'
import homeService from '../../service/HomeService'

@Component
export struct ClassTitle{
  @State categorys: Category[]=[]
  @State currentkey: number=0
  @State open: boolean = false
  aboutToAppear(){
    homeService.getCategorys(0).then((data: ArrayList<Category>)=>{
      if(data.length == 0){
        //默认数据
        let cate = new Category()
        cate.name="手机"
        cate.id=0
        let cate1 = new Category()
        cate1.name="电商"
        cate1.id=1
        this.currentkey=cate.id
        this.categorys=[cate]
        this.categorys=[cate,cate1]
      }else{
        this.categorys=data.convertToArray()
        this.currentkey=this.categorys[0].id
      }
    })
  }
  build(){
    Flex({justifyContent: FlexAlign.SpaceBetween}){
      ForEach(this.categorys,(it: Category)=>{
        Text(it.name)
          .fontSize($r('app.float.middle_font_size'))
          .opacity(this.currentkey === it.id ?  CommonConstants.FULL_OPACITY : CommonConstants.EIGHTY_OPACITY)
          .fontWeight(this.currentkey === it.id  ? CommonConstants.FONT_WEIGHT_SEVEN : CommonConstants.FONT_WEIGHT_FOUR)
          .fontColor(Color.White)
          .onClick(()=>{
              this.currentkey=it.id
          })
      },(it: Category)=> it.id.toString() )
      Row(){
        Image($r('app.media.ic_split_line'))
          .width($r('app.float.vp_one'))
          .height($r('app.float.vp_fourteen'))
        Image($r('app.media.ic_more'))
          .width($r('app.float.vp_sixteen'))
          .height($r('app.float.vp_sixteen'))
          .margin({
            left:  $r('app.float.vp_two'),
            right: $r('app.float.vp_two')
          })

        Text($r('app.string.title_bar_classification'))
          .fontSize($r('app.float.middle_font_size'))
          .fontColor(Color.White)
          .opacity(this.currentkey === -1 ?  CommonConstants.FULL_OPACITY : CommonConstants.EIGHTY_OPACITY)
          .fontWeight(this.currentkey === -1 ? CommonConstants.FONT_WEIGHT_SEVEN : CommonConstants.FONT_WEIGHT_FOUR)
      }
      .onClick(() => {
         this.currentkey=-1
      })
    }
    .margin({top:$r('app.float.vp_eight')})
    .width(CommonConstants.FULL_WIDTH)
  }
}