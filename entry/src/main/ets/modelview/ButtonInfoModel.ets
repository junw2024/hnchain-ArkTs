export class ButtonInfoModel {
  static readonly HOME_INDEX: number = 0;
  /**
   * Index of newProduct tab.
   */
  static readonly PRODUCT_INDEX: number = 1;
  /**
   * Index of shopCart tab.
   */
  static readonly CART_INDEX: number = 2;
  /**
   * Index of personal tab.
   */
  static readonly MY_INDEX: number = 3;

  index: number = 0
  img: Resource= $r('app.media.ic_home_normal')
  selectImg: Resource=$r('app.media.ic_home_focus')
  title: Resource =$r('app.string.home')
}

const buttonInfoArray: ButtonInfoModel[] = [
  {
    index: 0,
    img: $r('app.media.ic_home_normal'),
    selectImg: $r('app.media.ic_home_focus'),
    title: $r('app.string.home')
  },
  {
    index: 1,
    img: $r('app.media.ic_product_normal'),
    selectImg: $r('app.media.ic_product_focus'),
    title: $r('app.string.product')
  },
  {
    index: 2,
    img: $r('app.media.ic_cart_normal'),
    selectImg: $r('app.media.ic_cart_focus'),
    title: $r('app.string.cart')
  },
  {
    index: 3,
    img: $r('app.media.ic_personal_normal'),
    selectImg: $r('app.media.ic_personal_focus'),
    title: $r('app.string.mine')
  }
]

export  { buttonInfoArray }

