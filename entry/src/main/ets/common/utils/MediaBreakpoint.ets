import mediaQuery from '@ohos.mediaquery'
import BreakpointConstants from '../constants/BreakpointConstants';

class MediaBreakpoint {
  private currentBreakpoint: string = '';
  private smListener?: mediaQuery.MediaQueryListener;
  private mdListener?: mediaQuery.MediaQueryListener;
  private lgListener?: mediaQuery.MediaQueryListener;


  private updateCurrentBreakpoint(breakpoint: string){
    if(this.currentBreakpoint !== breakpoint) {
      this.currentBreakpoint = breakpoint;
      AppStorage.Set<string>(BreakpointConstants.CURRENT_BREAKPOINT,this.currentBreakpoint)
      if(BreakpointConstants.BREAKPOINT_SM === this.currentBreakpoint){
        AppStorage.Set<boolean>('isMinHeight',true);
      }else {
        AppStorage.Set<boolean>('isMinHeight',false);
      }
    }
  }

  private isBreakPointSM = (mediaQueryResult: mediaQuery.MediaQueryResult) =>{
    if(mediaQueryResult.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_SM);
    }
  }

  private isBreakPointMD = (mediaQueryResult: mediaQuery.MediaQueryResult) =>{
    if(mediaQueryResult.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_MD);
    }
  }
  private isBreakPointLG = (mediaQueryResult: mediaQuery.MediaQueryResult) =>{
    if(mediaQueryResult.matches) {
      this.updateCurrentBreakpoint(BreakpointConstants.BREAKPOINT_LG);
    }
  }


  public  register(): void {
    this.smListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_SM);
    this.smListener.on('change',this.isBreakPointSM);

    this.mdListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_MD);
    this.mdListener.on('change',this.isBreakPointMD);

    this.lgListener = mediaQuery.matchMediaSync(BreakpointConstants.RANGE_LG);
    this.lgListener.on('change',this.isBreakPointLG);
  }
  public unRegister(): void {
    this.smListener?.off('change',this.isBreakPointSM);
    this.mdListener?.off('change',this.isBreakPointMD);
    this.lgListener?.off('change',this.isBreakPointLG);
  }
}

let mediaBreakpoint = new MediaBreakpoint();
export default mediaBreakpoint as MediaBreakpoint;