package
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.Timer;
	
	public class Enemy extends MovieClip
	{
		public var chanceAttack:Boolean;
		private var dx:Number;
		private var timeBomb:Timer;
		private var randomPlaneModel:int=Math.ceil(Math.random()*3);
		
		public function Enemy(arah:String, posy:Number,speedx:Number)
		{
			this.gotoAndStop(randomPlaneModel);
			if(arah=="kanan")
			{
				this.x=600;
				dx=-speedx;
				this.scaleX=1;
			}
			else if(arah=="kiri")
			{
				this.x=-50;
				dx=speedx;
				this.scaleX=-1;
			}
			this.y=posy;
			timeBomb=new Timer(1000,Math.random()*2+1);
			timeBomb.addEventListener(TimerEvent.TIMER_COMPLETE, onBomb);
			timeBomb.start();
			addEventListener(Event.ENTER_FRAME, movePlane);
		}
		public function onBomb(event:TimerEvent)
		{
			chanceAttack=true;
		}
		public function movePlane(event:Event)
		{
			if(chanceAttack=true)
			{
				chanceAttack=false;
			}
			this.x +=dx;
			if(this.x<-50 || this.x>600)
			{
				deletePlane();
			}
		}
		
		public function deletePlane()
		{
			MovieClip(parent).removePlane(this);
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, movePlane);
		}
	}
}