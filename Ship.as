package
{
	import flash.display.*;
	import flash.events.*;
	
	public class Ship extends MovieClip
	{
		private var vx:Number=0.0;
		private var limitSpeed:Number=20;
		private var accel:Number=.2;
		private static const friction:Number=.93;
		
		public function Ship()
		{
			//menentukan posisi awal
			this.x=285;
			this.y=330;
			vx=0;
			addEventListener(Event.ENTER_FRAME, moveShip);
		}
		public function moveShip(event:Event)
		{
			//kondisi untuk menggerakan kapal ke kiri dan ke kanan
			if(MovieClip(parent).leftArrow)
			{
				vx -=accel;
			}
			else if(MovieClip(parent).rightArrow)
			{
				vx +=accel;
			}
			
			//membatasi kecepatan kapal
			if(vx >limitSpeed)
			{
				vx =limitSpeed;
			}
			if(vx <-limitSpeed)
			{
				vx =-limitSpeed;
			}
			//natural motion
			this.x +=vx;
			vx *=friction;
			if(Math.abs(vx)<0.1)
			{
				vx=0;
			}
			
			//membatasi area pergerakan
			if(this.x+(this.width/2)>550)
			{
				this.x=550-(this.width/2);
				vx=0;
			}
			if(this.x-(this.width/2)<0)
			{
				this.x=0+(this.width/2);
				vx=0;
			}
		}
		public function deleteShip()
		{
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, moveShip);
		}
	}
}