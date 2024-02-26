
import router from '@ohos.router';
import { Auth } from '../../model/Auth';
import LoginReq  from '../../model/LoginReq';
import loginService from '../../service/LoginService'
@Component
export struct LoginView {
  @StorageProp('isMinHeight')  isMinHeight: boolean=false;
  @State username: string=''
  @State password: string=''
  build(){
    GridRow(
      {columns:{sm:4,md:8 ,lg:12},
        gutter:{x: vp2px(12)},
        breakpoints:{value:['320vp','520vp','840vp']}
      }
    ) {
      GridCol({
        span:{sm:4,md:6,lg:8},
        offset:{sm:1,md:1,lg:2}
      }){
        Column(){
          TextInput({placeholder:$r('app.string.hnchain_username')})
            .width("100%")
            .height($r('app.float.text_input_height'))
            .placeholderColor($r('app.color.text_input_place_holder'))
            .placeholderFont({size: $r('app.float.text_input_font_size')})
            .backgroundColor($r('app.color.login_input_text_background'))
            .fontSize($r('app.float.text_input_font_size'))
            .padding({ left: $r('app.float.username_padding_left') })
            .border({
              width: {bottom: $r('app.float.input_border_width')},
              color: $r('app.color.input_border_color'),
              radius: $r('app.float.input_border_radius')
            })
            .onChange((val: string)=>{
              this.username=val
            })

          TextInput({ placeholder: $r('app.string.hnchain_password') })
            .width("100%")
            .height($r('app.float.text_input_height'))
            .placeholderColor($r('app.color.text_input_place_holder'))
            .placeholderFont({ size: $r('app.float.text_input_font_size') })
            .fontSize($r('app.float.text_input_font_size'))
            .backgroundColor($r('app.color.login_input_text_background'))
            .type(InputType.Password)
            .padding({ left: $r('app.float.password_padding_left') })
            .border({
              width: { bottom: $r('app.float.input_border_width') },
              color: $r('app.color.input_border_color'),
              radius: $r('app.float.input_border_radius')
            })
            .margin({ bottom: $r('app.float.input_margin_bottom') })
            .onChange((val: string)=>{
              this.password =val
            })

        }
      }

      GridCol(
        {
          span:{sm:4,md:this.isMinHeight? 3:6,lg:8},
          offset:{sm:0,md:2,lg:4}
        }
      ){
        Button($r('app.string.hnchain_login'))
          .width("100%")
          .height($r('app.float.login_btn_height'))
          .borderRadius($r('app.float.login_btn_border_radius'))
          .fontSize($r('app.float.text_input_font_size'))
          .margin({ top: $r('app.float.register_btn_margin_top') })
          .fontWeight(500)
          .enabled(isLoginButtonClickable(this.username,this.password))
          .fontColor(isLoginButtonClickable(this.username,this.password)?
          Color.White : $r('app.color.login_btn_normal'))
          .onClick(()=>{
            let req: LoginReq = new LoginReq()
            req.username=this.username
            req.password=this.password
            loginService.login(req).then((suc: boolean)=>{
              if(suc){
                router.replaceUrl({
                  url:"pages/MainIndex"
                })
              }
            })
          })
      }
      GridCol(
        {
          span: {
            sm: 4,
            md: this.isMinHeight ? 3 : 6,
            lg: 8
          },
          offset: {
            sm: 0,
            md: this.isMinHeight ?0 : 2,
            lg: 4
          }
        }
      ){
        Button($r('app.string.hnchain_register'))
          .width("100%")
          .height($r('app.float.login_btn_height'))
          .fontSize($r('app.float.text_input_font_size'))
          .fontWeight(500)
          .borderRadius($r('app.float.register_btn_border_radius'))
          .margin({ top: $r('app.float.register_btn_margin_top') })
          .fontColor($r('app.color.register_font_clickable'))
          .backgroundColor($r('app.color.register_btn_clickable'))
          .onClick(() => {
            router.pushUrl({
              url: ""
            });
          })
      }

    }
  }
}
function isLoginButtonClickable(username: string,password: string): boolean {
  return username != '' && password != ''
}