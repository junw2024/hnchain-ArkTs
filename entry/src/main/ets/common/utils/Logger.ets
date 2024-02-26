import hilog from '@ohos.hilog'
class Logger {
  private domain: number;
  private tag: string;
  private format: string = '%{public}s';
  constructor(tag: string = 'MyApp', domain: number = 0xFF00) {
    this.tag = tag;
    this.domain = domain;
  }
  debug(...args: String[]) :void {
    hilog.debug(this.domain,this.tag,this.format,args);
  }
  info(...args: string[]): void {
    hilog.info(this.domain, this.tag, this.format, args);
  }
  warn(...args: string[]): void {
    hilog.warn(this.domain, this.tag, this.format, args);
  }

  error(...args: string[]): void {
    hilog.error(this.domain, this.tag, this.format, args);
  }
}
export default new Logger('testTag', 0xFFF0)