require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import"cjson"
import"mk"
import "tools.Wallpaper.layout"
import"tools.Wallpaper.fl"


activity.setTheme(R.AndLua1)

activity.setTitle("壁纸分类")
activity.setContentView(loadlayout(layout))
控件隐藏(悬浮)
控件隐藏(悬浮1)

Http.get("http://service.picasso.adesk.com/v1/lightwp/category",function(a,b)
  if a~=200 then

    print("网络或其它错误")
   else
    b=cjson.decode(b)
    if b.msg=="success" then
      b=b.res.category
      data={}
      adp=LuaAdapter(activity,data,fl)
      for a,c in pairs(b) do
        --添加数据
        table.insert(data,{
          image={
            src=c.cover,
          },
          name={
            Text=c.rname,
          },
          id={
            Text=c.id
          },
        })
      end
      --设置适配器
      grid.Adapter=adp
    end
  end
end)


grid.onItemClick=function(l,v,p,i)
  activity.newActivity("tools/Wallpaper/bz",{v.Tag.id.Text,v.Tag.name.Text})
end




返回按钮()
--作者("So^")
