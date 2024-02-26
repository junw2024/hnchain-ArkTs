
const searchSwiperData: string[] = [
  '华为手机',
  'Thinkpad14+',
  '理想汽车',
  '特斯拉',
  '仙女年货'
]

class ActivityTitle {
  title?: Resource|string
  desc?:  Resource|string
}

const activityTitles: ActivityTitle[] =[
  {
    title:'全部',
    desc:'为你推存'
  },
  {
    title:'精选',
    desc:'发现好货'
  },
  {
    title:'实惠',
    desc:'便宜好货'
  }
]


export { searchSwiperData,activityTitles,ActivityTitle}


