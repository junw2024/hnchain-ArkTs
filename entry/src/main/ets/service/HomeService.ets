
import HashMap from '@ohos.util.HashMap';
import Category from '../model/Category';
import { get, post } from '../common/utils/http/HttpUtils';
import { Response } from '../common/utils/http/Response';
import ArrayList from '@ohos.util.ArrayList';
import Logger from '../common/utils/Logger';
import { Product } from '../model/Product';
import { Recommend } from '../model/Recommend';
import { CommonConstants } from '../common/constants/CommonConstants';
class HomeService {

  /**
   * 根据父类ID查询
   * @param parentid
   * @returns
   */
  public getCategorys(parentid: number): Promise<ArrayList<Category>> {
    let param = {"parentid": parentid}
    let list = new ArrayList<Category>()
    return post(CommonConstants.BASE_URL+'/v1/mall/categorys',null,param)
      .then((res : Response)=>{
        if(res.code === 200){
          res.data.categorys.forEach(it=>{
            eachCategory(it,list)
          })
        }else {
          Logger.error("getCategorys fail!:"+JSON.stringify(res))
        }
        return list
      })
  }

  /**
   * 获得推存商品页
   * @param recommend
   * @returns
   */
  public getRecommendPage(recommend: Recommend):Promise<ArrayList<Product>> {
    let list = new ArrayList<Product>()
    return post(CommonConstants.BASE_URL+'/v1/mall/recommend',null,recommend)
      .then((res: Response)=>{
        if(res.code === 200){
          if(res.data.products !== null){
            res.data.products.forEach(it => {
              let product = new Product()
              product.id = it.id
              product.name = it.name
              product.imageurl = it.imageurl
              Logger.info(JSON.stringify(product))
              list.add(product)
            })
          }
          recommend.cursor=res.data.recommendtime
          recommend.ps = 20
          recommend.productid= res.data.productid
          recommend.isEnd = res.data.isEnd
        }else {
          Logger.error("getRecommendPage fail!:"+JSON.stringify(res))
        }
        return list
      })
  }


}

function eachCategory(it: any,list: ArrayList<Category>):void {
  if (it === null || it === undefined) {
    return
  }
  let cate = new Category()
  cate.id = it.id
  cate.name = it.name
  cate.parentid = it.parentid
  if(it?.childs !== null) {
    cate.childs=new ArrayList<Category>()
    it.childs.forEach(ch=>{
      eachCategory(ch,cate.childs)
    })
  }
  list.add(cate)
}

let homeService = new HomeService()
export default  homeService  as HomeService