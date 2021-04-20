require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.net.Uri"
import "android.content.*"
import "android.text.Html"--html格式化
import "android.text.method.*"
import "android.support.v4.widget.*"--v4下拉
import "android.graphics.Typeface"--字体
import "android.graphics.PorterDuff"
import "android.graphics.PorterDuffColorFilter"
import "android.animation.ObjectAnimator"
import "android.view.animation.ScaleAnimation"
import "android.animation.ObjectAnimator"
import "android.animation.AnimatorSet"
import "android.database.sqlite.SQLiteDatabase"
import "android.view.animation.DecelerateInterpolator"
import "android.graphics.drawable.GradientDrawable"
import "java.io.File"--导入File类
import "android.database.sqlite.SQLiteDatabase"--sqllite数据库
import"fun.Encrypt"
im_time=os.clock()
Themdata=import"fun.Theme"

API="http://api.yesod.wang/api.php"

--引用 cjson库 并实例化它
cjson=import "cjson"
--设置md主题
activity.setTheme(android.R.style.Theme_DeviceDefault_Light)
--隐藏顶栏
activity.ActionBar.hide()
--状态栏高度
Bar_height=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
--粗体字
Bold=Typeface.defaultFromStyle(Typeface.BOLD)
--包名
PackageName=activity.getPackageName()
--利用包名获取到当前版本号
version=activity.getPackageManager().getPackageInfo(PackageName, 0).versionName

activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_PAN)

if Build.VERSION.SDK_INT >= 19 then
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
end

function uploge(name,key,van)

end
--控件可视
function 控件可视(a)
  a.setVisibility(View.VISIBLE)
end
--控件不可视,但占用空间
function 控件不可视(a)
  a.setVisibility(View.INVISIBLE)
end
--控件隐藏
function 控件隐藏(a)
  a.setVisibility(View.GONE)
end

function 复制(str)
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(str)
end

function 转0x(str)
  return tonumber("0x"..str:match("#(.+)"))
end

function 浏览器(url)
  import "android.content.Intent"
  import "android.net.Uri"
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(url))
  activity.startActivity(viewIntent)
end

function USB(time,sql)
  if this.getSharedData("开发者模式") then
    if sql=="" or sql==nil then
      print("用时:"..time.."秒")
     else
      print("Sql语句："..sql.."\n用时:"..time.."秒")
    end
  end
end
--dp转dx
function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end

function Base64编码(data)--编码
  local Base64=luajava.bindClass("android.util.Base64")
  return Base64.encodeToString(String(data).getBytes(),Base64.NO_WRAP);
end

function Base64解码(data)--解码
  local Base64=luajava.bindClass("android.util.Base64")
  return String(Base64.decode(data,Base64.DEFAULT)).toString()
end
function MB(str,mb)
  import"fun.MD5"
  xpcall(function()
    if mb=="mb" then
      return MD5(Base64编码(str))
     elseif mb=="m" then
      return MD5(str)
     elseif mb=="b" then
      return Base64编码(str)
    end
  end
  , function(err)
    uploge("函数","MB",(err))
  end)
end
function 储存(filname,title,str)
  xpcall(function()
    --获取SharedPreferences文件，后面的第一个参数就是文件名，没有会自己创建，有就读取
    sp = activity.getSharedPreferences(filname, Context.MODE_PRIVATE)
    --设置编辑
    sped = sp.edit()
    --设置键值对
    sped.putString(title,str)
    --提交保存数据数
    sped.commit()
    --print("储存成功")
  end
  , function(err)
    uploge("函数","储存",(err))
  end)
end

function 读取(filname,title)
  --获取SharedPreferences文件
  sp = activity.getSharedPreferences(filname, Context.MODE_PRIVATE)
  --打印对应的值
  return sp.getString(title,"")
  --print(sp.getString(title,""))
end
--水波纹
function 水波纹(id)
  xpcall(function()
    import "android.content.res.ColorStateList"
    local attrsArray = {android.R.attr.selectableItemBackgroundBorderless}
    local typedArray =activity.obtainStyledAttributes(attrsArray)
    ripple=typedArray.getResourceId(0,0)
    Pretend=activity.Resources.getDrawable(ripple)
    Pretend.setColor(ColorStateList(int[0].class{int{}},int{0x20000000}))
    id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{0x20000000})))
  end
  , function(err)
    uploge("函数","水波纹",err)
  end)
end
--按钮背景
function CircleButton(InsideColor,radiu)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  return drawable
  --view.setBackgroundDrawable(drawable)
end
function showD(id)--主页底栏项目高亮动画
  local kidt=id.getChildAt(0)
  local kidw=id.getChildAt(1)
  local animatorSet = AnimatorSet()
  local tscaleX = ObjectAnimator.ofFloat(kidt, "scaleX", {kidt.scaleX, 1.0})
  local tscaleY = ObjectAnimator.ofFloat(kidt, "scaleY", {kidt.scaleY, 1.0})
  local wscaleX = ObjectAnimator.ofFloat(kidw, "scaleX", {kidw.scaleX, 1.0})
  local wscaleY = ObjectAnimator.ofFloat(kidw, "scaleY", {kidw.scaleY, 1.0})
  animatorSet.setDuration(256)
  animatorSet.setInterpolator(DecelerateInterpolator());
  animatorSet.play(tscaleX)
  .with(tscaleY)
  .with(wscaleX)
  .with(wscaleY)
  animatorSet.start();
end

function closeD(id)--主页底栏项目灰色动画
  local gkidt=id.getChildAt(0)
  local gkidw=id.getChildAt(1)
  local ganimatorSet = AnimatorSet()
  local gtscaleX = ObjectAnimator.ofFloat(gkidt, "scaleX", {gkidt.scaleX, 0.9})
  local gtscaleY = ObjectAnimator.ofFloat(gkidt, "scaleY", {gkidt.scaleY, 0.9})
  local gwscaleX = ObjectAnimator.ofFloat(gkidw, "scaleX", {gkidw.scaleX, 0.9})
  local gwscaleY = ObjectAnimator.ofFloat(gkidw, "scaleY", {gkidw.scaleY, 0.9})
  ganimatorSet.setDuration(256)
  ganimatorSet.setInterpolator(DecelerateInterpolator());
  ganimatorSet.play(gtscaleX)
  .with(gtscaleY)
  .with(gwscaleX)
  .with(gwscaleY)
  ganimatorSet.start();
end

function 控件圆角(id,InsideColor,radiu)
  xpcall(function()
    import "android.graphics.drawable.GradientDrawable"
    drawable = GradientDrawable()
    drawable.setShape(GradientDrawable.RECTANGLE)
    drawable.setColor(InsideColor)
    drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
    id.setBackgroundDrawable(drawable)
  end
  , function(err)
    uploge("函数","控件圆角",err)
  end)
end

function 弹窗圆角(控件,背景色,角度)
  xpcall(function()
    if not 角度 then
      角度=25
    end

    local gd=GradientDrawable()
    .setShape(GradientDrawable.RECTANGLE)
    .setColor(背景色)
    .setCornerRadii({角度,角度,角度,角度,角度,角度,角度,角度,})
    if 控件 then
      控件.setBackgroundDrawable(gd)
    end
    return gd
  end
  , function(err)
    uploge("函数","弹窗圆角",err)
  end)

end

function E4A(txt,icon,color)
  xpcall(function()
    lay={
      LinearLayout;
      orientation="vertical";
      layout_height="fill";
      layout_width="fill";
      {
        LinearLayout;
        layout_gravity="center";
        layout_height="43dp";
        layout_width="-2";
        orientation="horizontal";
        id="bj";
        background="#FF4CAF50";
        {
          ImageView;
          layout_gravity="center";
          layout_height="23dp";
          layout_width="23dp";
          src="res/icon/"..tostring(icon)..".png";
          id="png";
          layout_marginLeft="18dp";
        };
        {
          TextView;
          Typeface=Bold;
          layout_gravity="center";
          layout_marginRight="18dp";
          textColor="#FFFFFF";
          text=txt;
          id="text";
          layout_marginLeft="8dp";
        };
      };
    };

    布局=loadlayout(lay)
    控件圆角(bj,color,360)
    local toast=Toast.makeText(activity,"",Toast.LENGTH_SHORT).setView(布局).show()
  end
  , function(err)
    uploge("函数","E4A",err)
  end)
end