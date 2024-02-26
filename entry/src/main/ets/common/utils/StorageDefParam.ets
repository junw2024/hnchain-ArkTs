
import { CommonConstants } from '../constants/CommonConstants'
export default  class StorageDefParam {
  public static setDefIndexPage() : void {
    AppStorage.Set<number>(CommonConstants.INDEX_PAGE,0)
  }
}