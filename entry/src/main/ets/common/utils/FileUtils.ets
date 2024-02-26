import  fs from '@ohos.file.fs'
export class FileUtils {
  public static async write(data: string, filePath: string){
    let file = await fs.open(filePath, fs.OpenMode.READ_WRITE);
    fs.write(file.fd,data).then((writeLen) =>{
      fs.close(file);
    }).catch(err => {
      console.error(`Failed to write data. Code is ${err.code}, message is ${err.message}`);
    })
  }
}