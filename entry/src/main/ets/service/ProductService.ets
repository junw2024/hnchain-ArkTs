
import { Product } from '../model/Product';
import { ProductPageParam } from '../model/ProductPageParam';
import ArrayList from '@ohos.util.ArrayList';
import { post } from '../common/utils/http/HttpUtils';
import { CommonConstants } from '../common/constants/CommonConstants';
import { Response } from '../common/utils/http/Response';
import Logger from '../common/utils/Logger';

class ProductService {
  private promotions: string[]=["推荐","新品","精品","秒杀"]
  public query(pageParam: ProductPageParam): Promise<ArrayList<Product>> {
    let list = new ArrayList<Product>()
    let param ={
      "cursor":pageParam.cursor,
      "categoryid":pageParam.categoryid,
      "ps": pageParam.ps,
      "productid": pageParam.productid,
      "sort": "sort"
    }
    return post(CommonConstants.BASE_URL+"v1/mall/categoryList",null,param)
      .then((res: Response)=>{
        if( res.code === 200){
          if (res.data.products !== null) {
            res.data.products.forEach(it =>{
              let p = new Product();
              p.id = it.id
              p.name = it.name
              p.imageurl = it.imageurl
              p.description = it.description
              p.price = it.price
              p.status = it.status
              p.stock = it.stock
              p.updatetime = it.updatetime
              p.createtime = it.createtime
              p.promotion=this.promotions[pageParam.promotionIndex]
              list.add(p)
            })
          }
          pageParam.cursor = res.data.lastVal
          pageParam.isEnd =  res.data.isEnd
          pageParam.productid = res.data.productid
        }else {
          Logger.error("ProductService:query fail!:"+JSON.stringify(res))
        }
        return list
    })
  }
}

let productService = new ProductService()
export default  productService as ProductService