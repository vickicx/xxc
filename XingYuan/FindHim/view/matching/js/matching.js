$(document).ready(function(){
    $(".TA_income").fadeIn(1000);
    $(".TA_user_height").fadeIn(2000);
    $(".TA_buy_room").fadeIn(3000);
    $(".TA_age").fadeIn(1000);
    $(".TA_education").fadeIn(2000);
    $(".TA_marriage").fadeIn(3000);
    
    $(".ME_income").fadeIn(1000);
    $(".ME_user_height").fadeIn(2000);
    $(".ME_buy_room").fadeIn(3000);
    $(".ME_age").fadeIn(1000);
    $(".ME_education").fadeIn(2000);
    $(".ME_marriage").fadeIn(3000);
});

    window.onload = function(){
        var canvas = document.getElementById('canvas'),  //获取canvas元素
            context = canvas.getContext('2d'),  //获取画图环境，指明为2d
            centerX = canvas.width/2,   //Canvas中心点x轴坐标
            centerY = canvas.height/2,  //Canvas中心点y轴坐标
            rad = Math.PI*2/100, //将360度分成100份，那么每一份就是rad度
            speed = 0.1; //加载的快慢就靠它了 
            
        //绘制5像素宽的运动外圈
        function blueCircle(n){
            context.save();
            context.strokeStyle = "#f6567b"; //设置描边样式
            context.lineWidth = 5; //设置线宽
            context.beginPath(); //路径开始
            context.arc(centerX, centerY, 42 , -Math.PI/2, -Math.PI/2 +n*rad, false); //用于绘制圆弧context.arc(x坐标，y坐标，半径，起始角度，终止角度，顺时针/逆时针)
            context.stroke(); //绘制
            context.closePath(); //路径结束
            context.restore();
        }
        //绘制白色外圈
        function whiteCircle(){
            context.save();          
            context.strokeStyle = "gainsboro";
            context.lineWidth = 5; //设置线宽
            context.beginPath();
            context.arc(centerX, centerY, 42 , 0, Math.PI*2, false);
            context.stroke();
            context.closePath();
            context.restore();
        }  
        //百分比文字绘制
        function text(n){
            context.save(); //save和restore可以保证样式属性只运用于该段canvas元素
            context.strokeStyle = "gainsboro"; //设置描边样式
            context.font = "30px Arial "; //设置字体大小和字体           
            //绘制字体，并且指定位置
            context.fillStyle = "#f26081";
            context.fillText(n.toFixed(0)+"%", centerX-25, centerY+10);
            context.stroke(); //执行绘制
            context.restore();
        } 
        //动画循环
        (function drawFrame(){
//      	 if(speed>90){            
//          	return
//          }
            window.requestAnimationFrame(drawFrame);
            context.clearRect(0, 0, canvas.width, canvas.height);
            whiteCircle();
            text(speed);
            blueCircle(speed);
            if(speed > 100){
            	speed = 0         
            }
            speed += 1;
        }());
        setInterval(yy,50)
    }
var  canvas2 = document.getElementById('canvas2')  //获取canvas元素
var  ctx= canvas2.getContext('2d')
     function yy(){
     ctx.clearRect(0,0,700,500)
     ctx.fillStyle="white";
     ctx.arc(105,105,103,360*Math.PI/180,false);
     ctx.fill();
     ctx.save();
     //  用循环创建刻度
        ctx.translate(105,105);
        for(i=0;i<60;i++){
            ctx.beginPath();
            ctx.moveTo(80,0);
            ctx.lineTo(103,0);
            ctx.strokeStyle="#c7c7c7"          
            ctx.closePath();
            ctx.stroke();
            ctx.rotate(6*Math.PI/180);
        }
        ctx.restore();
     }
//请求接口     
//$(document).ready(function (){
//  $.ajax({
//      type: 'post',
//      url: '/webinterfaceservice/GetNewsByIDCode?',
//      dataType: 'json',
//      data: { "data": "{ \"idcode\": \"ProductIntroduction\",\"newscount\": 3 }" },
//      success: function (data) {
//      	
//      	
//      }
//         
//  });
//});

$(document).ready(function(){
	var mW = 600;
    var mH = 600;
    var mData = [['家庭情况', 77],
                            ['个人情况', 72],
                            ['认证资料', 46],
                            ['其他', 50],
                            ['未来规划', 80],
                            ['基本资料', 60]];
    var mCount = mData.length; //边数 
    var mCenter = mW /2; //中心点
    var mRadius = mCenter - 120; //半径(减去的值用于给绘制的文本留空间)
    var mAngle = Math.PI * 2 / mCount; //角度
    var mCtx = null;
    var mColorPolygon = '#d4d2d2'; //多边形颜色
    var mColorLines = '#B8B8B8'; //顶点连线颜色
    var mColorText = '#443e3f';
  
    //初始化
    (function(){
      var canvas = document.createElement('canvas');
      $("#chart").append(canvas);    
      $("#chart").css({"height":mH+'px'})
      $("#chart canvas").css({"position":"absolute","left":"50%","margin-left":-mCenter+'px'})
      canvas.height = mH;
      canvas.width = mW;
      mCtx = canvas.getContext('2d');
  
      drawPolygon(mCtx);
      drawLines(mCtx);
      drawText(mCtx);
      drawRegion(mCtx);
//    drawCircle(mCtx);
    })();
  
      // 绘制多边形边
      function drawPolygon(ctx){
        ctx.save();
  
        ctx.strokeStyle = mColorPolygon;
        var r = mRadius/ mCount; //单位半径
        //画6个圈
        for(var i = 0; i < 6; i ++){
            ctx.beginPath();        
            var currR = r * ( i + 1); //当前半径
            //画6条边
            for(var j = 0; j < mCount; j ++){
                var x = mCenter + currR * Math.cos(mAngle * j);
                var y = mCenter + currR * Math.sin(mAngle * j);
  
                ctx.lineTo(x, y);
            }
            ctx.closePath()
            ctx.stroke();
        }
  
        ctx.restore();
      }
  
    //顶点连线
    function drawLines(ctx){
        ctx.save();
  
        ctx.beginPath();
        ctx.strokeStyle = mColorLines;
  
        for(var i = 0; i < mCount; i ++){
            var x = mCenter + mRadius * Math.cos(mAngle * i);
            var y = mCenter + mRadius * Math.sin(mAngle * i);
  
            ctx.moveTo(mCenter, mCenter);
            ctx.lineTo(x, y);
        }
  
        ctx.stroke();
  
        ctx.restore();
    }
  
    //绘制文本
    function drawText(ctx){
        ctx.save();
  
        var fontSize = 26;
        ctx.font = fontSize + 'px Microsoft Yahei';
        ctx.fillStyle = mColorText;
  
        for(var i = 0; i < mCount; i ++){
            var x = mCenter + mRadius * Math.cos(mAngle * i);
            var y = mCenter + mRadius * Math.sin(mAngle * i);
  
            if( mAngle * i >= 0 && mAngle * i <= Math.PI / 2 ){           	
                ctx.fillText(mData[i][0], x+15, y + 10); 
            }else if(mAngle * i > Math.PI / 2 && mAngle * i <= Math.PI){
                ctx.fillText(mData[i][0], x - ctx.measureText(mData[i][0]).width-15, y + 10);    
            }else if(mAngle * i > Math.PI && mAngle * i <= Math.PI * 3 / 2){
                ctx.fillText(mData[i][0], x - ctx.measureText(mData[i][0]).width, y-15);   
            }else{
                ctx.fillText(mData[i][0], x, y-15);
            }
  
        }
  
        ctx.restore();
    }
  
    //绘制数据区域
    function drawRegion(ctx){
        ctx.save();
  
        ctx.beginPath();
        for(var i = 0; i < mCount; i ++){
            var x = mCenter + mRadius * Math.cos(mAngle * i) * mData[i][1] / 100;
            var y = mCenter + mRadius * Math.sin(mAngle * i) * mData[i][1] / 100;
  
            ctx.lineTo(x, y);
        }
        ctx.closePath();
        ctx.fillStyle = 'rgba(246, 80, 118, 0.3)';
        ctx.fill();
  
        ctx.restore();
    }
 
})
//$(document).ready(function(){
//	$(window).scroll(function(){	
//		if($(window).scrollTop()>810){
//			$("#chart").fadeIn(2000)
//		}
//	})
//	
//})