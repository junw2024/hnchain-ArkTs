import  http from '@ohos.net.http'
import { RequestMethod } from './RequestMethod'
import { Response } from './Response'
import Logger from '../Logger'
import HashMap from '@ohos.util.HashMap'
//导出httpRequest请求函数

function handleResult(responseResult:Promise<http.HttpResponse>): Promise<Response> {
  let response = new Response();
  return responseResult.then((val: http.HttpResponse)=>{
    if(val.responseCode === http.ResponseCode.OK) {
      let res: Response = JSON.parse(`${val.result}`)
      return res
    }else {
      response.msg = 'http request error!';
      response.code = 400;
      Logger.error("http request error:"+JSON.stringify(val))
    }
    return response
  }).catch((err)=>{
    response.msg = 'http request  unknown error!';
    response.code = 400;
    Logger.error("http request unknown error:"+JSON.stringify(err))
    return response
  })
}
export function request(url: string,method: RequestMethod, requestData?: any): Promise<Response>{
  let httpRequest = http.createHttp()
  let responseResult = httpRequest.request(
    url,
    {
      method: method,
      header:{
        'Content-Type': 'application/json'
      },
      //携带额外参数
      extraData: JSON.stringify(requestData),
      //可选，默认为60000ms
      connectTimeout: 60000,
      readTimeout: 60000,
    }
  )
  return handleResult(responseResult)
}

export function post(url: string,header: HashMap<string,string>,requestData?: any): Promise<Response> {
  let reqHeader :HashMap<string,string> = new HashMap<string,string>()
  if(header === null){
    reqHeader.set("Content-Type","application/json")
  }else {
    reqHeader.forEach((val,key)=>{
      reqHeader.set(key,val)
    })
    if(!reqHeader.hasKey("Content-Type")){
      reqHeader.set("Content-Type","application/json")
    }
  }

  let httpRequest = http.createHttp()
  let responseResult = httpRequest.request(
    url,
    {
      method: RequestMethod.POST,
      header:toJson(reqHeader),
      //携带额外参数
      extraData: JSON.stringify(requestData),
      //可选，默认为60000ms
      connectTimeout: 60000,
      readTimeout: 60000,
    }
  )
  return handleResult(responseResult)
}

export function get(url: string,header: HashMap<string,string>,requestData?: any): Promise<Response>{
  let reqHeader :HashMap<string,string> = new HashMap<string,string>()
  if(header !== null){
    reqHeader.forEach((val,key)=>{
      reqHeader.set(key,val)
    })
  }
  let httpRequest = http.createHttp()
  let responseResult = httpRequest.request(
    url,
    {
      method: RequestMethod.POST,
      header:toJson(reqHeader),
      //携带额外参数
      extraData: JSON.stringify(requestData),
      //可选，默认为60000ms
      connectTimeout: 60000,
      readTimeout: 60000,
    }
  )
  return handleResult(responseResult)
}

function toJson(mp: HashMap<string,string>): string {
  let rt={}
  mp.forEach((val: string,key :string)=>{
    rt[key]=val
  })
  return JSON.stringify(rt)
}




