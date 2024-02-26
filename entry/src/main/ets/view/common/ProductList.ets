
import { CommonConstants } from '../../common/constants/CommonConstants'
import { CommonDataSource } from '../../common/data/CommonDataSuoce'
import { Product } from '../../model/Product'
import { ProductPageParam } from '../../model/ProductPageParam'
import productService from '../../service/ProductService'

import { PullToRefresh} from '@ohos/pulltorefresh'


@Component
export struct ProductList {

  @State  prodcutData: CommonDataSource<Product> = new CommonDataSource<Product>()
  @Prop   colnum: number
  private  paramPage: ProductPageParam = new ProductPageParam(10,0,0)
  private onClickItem? = (item: Product) => {};

  // 滚动：需绑定列表或宫格组件
  private scroller: Scroller = new Scroller()

  aboutToAppear(){
    productService.query(this.paramPage).then(data=>{
      data.forEach(it=>{
        this.prodcutData.addData(it)
      })
    })
  }
  @Builder Item(it: Product){
    Column(){
      Image($rawfile(it.imageurl))
        .width($r('app.float.product_item_image_size'))
        .height($r('app.float.product_item_image_size'))
        .objectFit(ImageFit.Contain)
        .margin({
          top:$r('app.float.vp_sixteen'),
          bottom:$r('app.float.vp_eight')
        })
      Column(){
        Text('【'+it.name+'】'+it.description)
          .fontSize($r('app.float.small_font_size'))
          .fontWeight(CommonConstants.FONT_WEIGHT_FOUR)
          .fontColor(Color.Black)
          .maxLines(CommonConstants.TWO_TEXT_LINE)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .lineHeight($r('app.float.product_desc_height'))
        Text('%￥'+it.price)
          .fontColor($r('app.color.focus_color'))
          .fontSize($r('app.float.middle_font_size'))
          .margin({
            top: $r('app.float.vp_four'),
            bottom: $r('app.float.vp_eight')
          })

        Text(it.promotion)
          .fontSize($r('app.float.micro_font_size'))
          .fontColor(Color.White)
          .backgroundColor($r('app.color.focus_color'))
          .borderRadius($r('app.float.vp_four'))
          .height($r('app.float.vp_sixteen'))
          .padding({
            right: $r('app.float.vp_eight'),
            left: $r('app.float.vp_eight')
          })

      }
      .width(CommonConstants.FULL_WIDTH)
      .alignItems(HorizontalAlign.Start)
    }
    .width(CommonConstants.FULL_WIDTH)
    .padding($r('app.float.vp_twenty'))
    .height($r('app.float.product_item_height'))
    .backgroundColor(Color.White)
    .borderRadius($r('app.float.vp_eight'))


  }

  @Builder ListView() {
    List({space: CommonConstants.TWELVE_SPACE}){
      LazyForEach(this.prodcutData,(it: Product,index: number)=>{
        ListItem(){
          this.Item(it)
        }
        .margin({right:$r('app.float.vp_six'),left:$r('app.float.vp_six')})
        .onClick(()=>{
          if(this.onClickItem != undefined){
            this.onClickItem(it)
          }
        })
      },(it: Product)=> it.id.toString())
    }
    .margin({
      left: $r('app.float.product_list_margin'),
      right: $r('app.float.product_list_margin') })
    .lanes(this.colnum)
    .listDirection(Axis.Vertical)
  }

  build() {
    Column() {
      PullToRefresh({
        //必传项，列表组件所绑定的数据
        data:$prodcutData,
        // 必传项，需绑定传入主体布局内的列表或宫格组件
        scroller: this.scroller,
        // 必传项，自定义主体布局，内部有列表或宫格组件
        customList:()=>{
          this.ListView()
        },
        // 可选项，下拉刷新回调
        onRefresh:()=>{
          return null
        },
        // 可选项，上拉加载更多回调
        onLoadMore:()=>{
          return new Promise<string>((resolve, reject)=>{
            if(!this.paramPage.isEnd){
              productService.query(this.paramPage).then(data=>{
                data.forEach(it=>{
                  this.prodcutData.addData(it)
                })
                resolve('加载完成')
              })
            }else {
              resolve('暂无数据加载')
            }
          })
        },
        customLoad: null,
        customRefresh: null,
      })
    }
  }

}