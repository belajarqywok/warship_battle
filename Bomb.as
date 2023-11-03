package
{
	import flash.display.*;
	import flash.events.*;
	
	public class Bomb extends MovieClip
	{
		private var dy:int;
		
		public function Bomb(x,y:Number, speed:Number)
		{
			dy=speed;
			this.x=x;
			this.y=y;
			addEventListener(Event.ENTER_FRAME, moveBomb);
		}
		public function moveBomb(event:Event)
		{
			this.y +=dy;

			if(this.y>400)
			{
				deleteBomb();
			}
		}
		public function deleteBomb()
		{
			MovieClip(parent).removeBomb(this);
			parent.removeChild(this);
			removeEventListener(Event.ENTER_FRAME, moveBomb);
		}
	}
}