import { CommonConstants } from '../common/constants/CommonConstants';
import Logger from '../common/utils/Logger'
import { Auth } from '../model/Auth';
import LoginReq from '../model/LoginReq';
import {post} from '../common/utils/http/HttpUtils'
import { Response } from '../common/utils/http/Response';
import globalData  from '../common/constants/GlobalData';

class LoginService {
  private gLocalAuth = globalData.getInstance();
  /**
   * @param username 用户
   * @param password 密码
   * @param page 跳
   * 转页面
   */
  public login(loginReq: LoginReq): Promise<boolean> {
   return post(CommonConstants.BASE_URL+'/v1/user/login',null,loginReq)
      .then((res: Response)=>{
        if( res.code === 200){
          let auth: Auth = new Auth()

          auth.token=res.data.accessToken
          auth.expire=res.data.accessExpire

          this.gLocalAuth.set(globalData.TG_AUTH,JSON.stringify(auth));
          return true

        }else{
          AppStorage.Delete(CommonConstants.LOGIN_AUTH)
          Logger.error("login fail!:"+JSON.stringify(res))
          return false
        }
    })
  }
  public getAuth(): Auth {
    return AppStorage.Get<Auth>(CommonConstants.LOGIN_AUTH);
  }
  public isLogin(): boolean {
    let val: string = this.gLocalAuth.get(globalData.TG_AUTH)
    if(val === undefined || val ===  null || val === "") {
      return false;
    }

    let auth: Auth = JSON.parse(val)
    if(auth.token !== ''){
      return true
    }
    return false;
  }
}

let loginService = new LoginService()
export default loginService as LoginService