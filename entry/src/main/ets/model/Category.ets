
import ArrayList from '@ohos.util.ArrayList'

export default  class Category {
  id: number
  //名称
  name: string
  //父ID
  parentid: number
  //子节集合
  childs?: ArrayList<Category>
}