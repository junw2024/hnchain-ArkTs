import UIAbility from '@ohos.app.ability.UIAbility';
import window from '@ohos.window';
import Logger from '../common/utils/Logger'
import windManager from '../common/utils/WindowManager'

let windowClass = null;
export default class EntryAbility extends UIAbility {


  onCreate(want, launchParam) {
    Logger.info('Ability onCreate');
    let uiAbilityContext = this.context;
  }

  onDestroy() {
    Logger.info('Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {

    Logger.info( 'Ability onWindowStageCreate');

    let barManager = windManager.getInstance()
    barManager.setWindowStage(windowStage);

    //设置沉浸式状态栏
    barManager.immersiveStatusBar()
    windowStage.loadContent('pages/MainIndex', (err, data) => {
      if (err.code) {
        Logger.error(JSON.stringify(err)?? '');
        return;
      }
      Logger.info(JSON.stringify(data) ?? '');
    });
  }

  onWindowStageDestroy() {
    Logger.info('Ability onWindowStageDestroy');
  }

  onForeground() {
    Logger.info('Ability onForeground');
  }
  onBackground() {
    Logger.info('Ability onBackground');
  }
}
