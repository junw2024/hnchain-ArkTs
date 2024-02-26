
export class ProductPageParam {
  cursor: number         //下一页的条件值
  categoryid: number    //商品类别ID
  productid: number      //页结束商品ID
  ps: number             //每页大小
  isEnd: boolean         //是否结束
  promotionIndex: number
  constructor(ps: number,categoryid: number,promotionIndex: number) {
    this.ps= ps
    this.categoryid=categoryid
    this.promotionIndex= promotionIndex
  }
}