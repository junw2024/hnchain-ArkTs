
import ArrayList from '@ohos.util.ArrayList';
export class CommonDataSource<T> implements IDataSource {
  private data: ArrayList<T> = new ArrayList<T>()
  private listeners: ArrayList<DataChangeListener> = new ArrayList<DataChangeListener>()

  //constructor(data: ArrayList<T>) {
  // this.data=data
  //}

  getData(index: number): T {
    return this.data[index]
  }

  changeData(index: number,item: T): void {
    if (index >= 0 && index < this.data.length) {
      this.data[index]=item
      this.notifyDataChange(index)
    }
  }
  deleteData(index: number): void {
    if (index >= 0 && index < this.data.length) {
      this.data.removeByIndex(index)
      this.notifyDataDelete(index)
    }
  }
  addData(item: T){
    this.data.add(item)
    this.notifyDataAdd(this.data.length-1)
  }


  totalCount(): number {
    return this.data.length
  }





  // 该方法为框架侧调用，为LazyForEach组件向其数据源处添加listener监听
  registerDataChangeListener(listener: DataChangeListener): void {
    if(this.listeners.getIndexOf(listener) < 0){
      this.listeners.add(listener)
    }
  }

  //该方法为框架侧调用，为对应的LazyForEach组件在数据源处去除listener监听
  unregisterDataChangeListener(listener: DataChangeListener): void {
    let pos: number =this.listeners.getIndexOf(listener)
    if(pos > -1){
      this.listeners.removeByIndex(pos)
    }
  }

  //通知LazyForEach组件需要重载所有子组件
  notifyDataReload(): void{
    this.listeners.forEach((listener: DataChangeListener ) =>{
      listener.onDataReloaded()
    })
  }
  //通知LazyForEach组件需要在index对应索引处添加子组件
  notifyDataAdd(index: number): void{
    this.listeners.forEach((listener: DataChangeListener)=>{
      listener.onDataAdd(index)
    })
  }
  //通知LazyForEach组件在index对应索引处数据有变化，需要重建该子组件
  notifyDataChange(index: number): void {
    this.listeners.forEach((listener: DataChangeListener) => {
      listener.onDataChange(index)
    })
  }

  //通知LazyForEach组件需要在index对应索引处删除该子组件
  notifyDataDelete(index: number): void {
    this.listeners.forEach((listener: DataChangeListener)=>{
      listener.onDataDelete(index)
    })
  }
}