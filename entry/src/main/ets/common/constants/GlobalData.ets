/**
 * 全局本地存储单例
 */
export default  class GlobalData {
  public  static readonly TG_AUTH: string = "auth"
  private storage: LocalStorage = new LocalStorage();
  private static instance: GlobalData
  private constructor() {
  }

  public static getInstance(): GlobalData {
    if(!this.instance){
      this.instance =new GlobalData()
    }
    return this.instance
  }

  public set(key: string, val: string): void {
    this.storage.setOrCreate<string>(key,val)
  }
  public get(key: string): string {
    return this.storage.get<string>(key)
  }
}