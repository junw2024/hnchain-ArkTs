
import HashMap from '@ohos.util.HashMap';
import window from '@ohos.window';
import Logger from '../../common/utils/Logger'
/**
 * 窗口状态栏管理
 */
export default  class WindowManager {
  //private readonly TAG = 'StatusBarManager';
  private readonly CONFIG_SYSTEM_BAR_HEIGHT = 'systemBarHeight';
  private static instance: WindowManager
  private windowStage: window.WindowStage;
  private mConfig = new HashMap<string,any>()
  private

  //单例模式
  private constructor() {
  }
  public static getInstance(): WindowManager {
    if(!this.instance){
      this.instance =new WindowManager()
    }
    return this.instance
  }
  /**
   * 存储windowStage实例
   * @param windowStage
   * 存储windowStage实例,该方法在UIAbility中进行调用。
   */
  public setWindowStage(windowStage: window.WindowStage): void {
    this.windowStage = windowStage
  }
  /**
   * 获取windowStage实例
   * @returns
   */
  public getWindowStage(): window.WindowStage {
    return this.windowStage
  }

  /**
   * 获取窗口状态栏高度进行保存
   */
  private storeStatusBarHeight(windowClass: window.Window): void {
    try{
      const avoidArea= windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
      // 保存高度信息
      this.mConfig.set(this.CONFIG_SYSTEM_BAR_HEIGHT,avoidArea.topRect.height)
      Logger.info('Succeeded in obtaining the area. Data:' + JSON.stringify(avoidArea));
    }catch(err){
      Logger.error('Failed to obtain the area. Cause:' + JSON.stringify(err));
    }
  }


  public immersiveStatusBar():Promise<void>  {
    let resolveFn, rejectFn;
    let promise = new Promise<void>((resolve, reject) => {
      resolve=resolveFn
      reject=resolveFn
    })

      //获取应用主窗口
      this.windowStage.getMainWindow().then((mWindow)=> {
        Logger.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(mWindow))
        //实现沉浸式效果：设置窗口可以全屏绘制,将UI内容顶入状态栏下方.
        mWindow.setWindowLayoutFullScreen(true).then(()=>{
          //设置状态栏 可见
          mWindow.setWindowSystemBarEnable(['status']).then(()=>{
            //设置状态栏透明背景
            const systemBarProperties: window.SystemBarProperties = {
              statusBarColor: '#00000000'
            }
            //设置窗口内导航栏、状态栏的属性
            mWindow.setWindowSystemBarProperties(systemBarProperties).then(()=>{
              Logger.info('Succeeded in setting the system bar properties.');
            })
          })
          //存储状态栏高度
          this.storeStatusBarHeight(mWindow)
        }).catch((err)=>{
          Logger.error('Failed to obtain the main window. Cause: ' + JSON.stringify(err));
        })
        resolveFn()
      }).catch((err)=>{
         rejectFn(err)
      })

    return promise
  }

  /**
   * 关闭沉浸式状态栏
   * @returns
   */
  public hideImmersiveStatusBar(): Promise<void> {
    let resolveFn, rejectFn;
    let promise = new Promise<void>((resolve, reject) => {
      resolve=resolveFn
      reject=resolveFn
    })

    //获取应用主窗口
    this.windowStage.getMainWindow().then(mWindow=>{
      Logger.info('Succeeded in obtaining the main window. Data: ' + JSON.stringify(mWindow));
      mWindow.setWindowLayoutFullScreen(false)
        .then(()=>{
          //储状态栏高度
          this.mConfig.set(this.CONFIG_SYSTEM_BAR_HEIGHT, 0);
        })
      resolveFn()
    }).catch(err =>{
      rejectFn(err)
    })
    return promise
  }

  /**
   * 未开启沉浸式状态栏，偏移量为0，开启， 偏移量为状态栏高度
   * @returns
   */
  public getSystemBarOffset(): number {
    let height=0
    if(this.mConfig.hasKey(this.CONFIG_SYSTEM_BAR_HEIGHT)){
      height = this.mConfig.get(this.CONFIG_SYSTEM_BAR_HEIGHT) as number
    }
    return height
  }
  /**
   * 是否开启沉浸式状态栏
   */
  public isOpenImmersiveStatusBar(): boolean {
    return this.getSystemBarOffset() > 0;
  }

  /**
   * 禁止横屏
   * @returns
   */
  public orientationPortrait(): Promise<void> {
    let resolveFn, rejectFn;
    let promise = new Promise<void>((resolve, reject) => {
      resolve=resolveFn;
      reject=resolveFn;
    })
    this.windowStage.getMainWindow().then(mWindow=>{
        mWindow.setPreferredOrientation(window.Orientation.PORTRAIT).then(
          resolveFn()
        ).catch(err=>{
          Logger.error("set window Orientation fail:",JSON.stringify(err));
          rejectFn(err)
        })
    })
    return promise;
  }
}