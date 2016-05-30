window.onload=function(){
				var popbox=document.querySelector(".m-pop"),
				    detail=document.querySelector(".m-detail"),	
				    cover=document.querySelector(".m-cover"),
				    ml = document.querySelectorAll(".pop_con a"),
				    headerIcon=document.querySelector(".header_icon"),
				    gotop=document.querySelector(".m-gotoTop"),
				    flag=true;
				
				gotop.addEventListener("click",gotoTop,false);
				
				cover.addEventListener("click",function(){
						closePop();
						flag=true;
					},false); //点击遮罩层关闭弹出框
				
				for( var i = 0 , j = ml.length ; i < j ; i++ ){
					ml[i].addEventListener("click",function(){
						closePop();
						flag=true;
					},false); //点击目录关闭弹出框
				}
				headerIcon.addEventListener("click",function(){ //点击头部右侧图标
				   if(flag){
						openPop();
//						window.scroll(0,0);
						flag=false;
				   }else{ 
					   closePop();
					   flag=true;
				  }
				},false);
				
				function stopParat(e){//阻止默认事件
					 e.preventDefault(); 
				}
				function closePop(){//关闭弹出框
					popbox.style.right="-75%";
					detail.style.position="static";
					popbox.style.display="none";		
					cover.style.display="none";	
					cover.removeEventListener("touchmove",stopParat,false);
					detail.removeEventListener("touchmove",stopParat,false); 
				}
				function openPop(){//打开弹出框
					popbox.style.right="0";
					detail.style.position="fixed";
					popbox.style.display="block";		
					cover.style.display="block";
					detail.addEventListener("touchmove",stopParat,false);
					cover.addEventListener("touchmove",stopParat,false);  	
				}
				//返回顶部
				function gotoTop(){
					window.scroll(0,0);
				}
				
			}

