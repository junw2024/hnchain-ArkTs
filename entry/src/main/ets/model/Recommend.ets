
export class Recommend {
  constructor(cusor: number,productid: number,ps: number,isEnd: boolean ) {
    this.cursor = cusor
    this.productid = productid
    this.ps = ps
    this.isEnd =isEnd
  }
  cursor: number
  productid: number
  ps: number
  isEnd: boolean
}