package
{
	import flash.display.*;
	import flash.events.*;
	
	public class Bullet extends MovieClip
	{
		private var dy:int;
		
		public function Bullet(xpos,ypos:Number, speed:Number)
		{
			dy=speed;
			this.x=xpos;
			this.y=ypos;
			
			addEventListener(Event.ENTER_FRAME, moveBullet);
		}
		public function moveBullet(event:Event)
		{
			this.y -=dy;

			if(this.y<0)
			{
				deleteBullet();
			}
		}
		public function deleteBullet()
		{
			MovieClip(parent).removeBullet(this);
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, moveBullet);
		}
	}
}