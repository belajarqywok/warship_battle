package
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	
	public class Main extends MovieClip
	{
		private var ship_mc:Ship;
		private var enemies:Array;
		private var bullets:Array;
		private var bombs:Array;
		private var timerNewEnemy:Timer;
		public var leftArrow:Boolean=false;
		public var rightArrow:Boolean=false;
		private var attackMode:Boolean=true;
		private var timeToAttack:Boolean=false;
		private var enemyHit:int=0;
		private var score:int=0;
		
		private var stat:String;
		
		public function startGame()
		{
			bullets=new Array();
			enemies=new Array();
			bombs=new Array();
			ship_mc=new Ship();
			addChildAt(ship_mc,1);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
			addEventListener(Event.ENTER_FRAME, onFrame);
			setUpEnemy();
			showGameScore();
			score=0;
			enemyHit=0;
		}
		public function setUpEnemy()
		{
			timerNewEnemy=new Timer(1000+Math.random()*1000,1);
			timerNewEnemy.addEventListener(TimerEvent.TIMER_COMPLETE, newEnemy);
			timerNewEnemy.start();
		}
		public function newEnemy(event:TimerEvent)
		{
			if(Math.random()>.5)
			{
				var side:String="kiri";
			}
			else
			{
				side="kanan";
			}
			var posY:Number=Math.random()*50+20;
			var speed:Number=Math.random()*5+10;
			var e:Enemy=new Enemy(side,posY,speed);
			addChild(e);
			enemies.push(e);
			setUpEnemy();
		}
		
		public function onDown(event:KeyboardEvent)
		{
			if(event.keyCode==37)
			{
				leftArrow=true;
			}
			else if(event.keyCode==39)
			{
				rightArrow=true;
			}
			else if(event.keyCode==32)
			{
				if(attackMode)
				{
					timeToAttack=true;
				}
			}
		}
		public function onUp(event:KeyboardEvent)
		{
			if(event.keyCode==37)
			{
				leftArrow=false;
			}
			if(event.keyCode==39)
			{
				rightArrow=false;
			}
			if(event.keyCode==32)
			{
				attackMode=true;
			}
		}

		public function attack()
		{
			var b:Bullet=new Bullet(ship_mc.x,ship_mc.y,10);
			addChild(b);
			bullets.push(b);
			attackMode=false;
		}
		
		public function onFrame(event:Event)
		{
			//mode tembak pada saat tombol spasi di tekan
			if(timeToAttack)
			{
				timeToAttack=false;
				attack();
			}
			//membatasi jumlah bullet pada kapal
			if(bullets.length>1)
			{
				attackMode=false;
			}
			
			for(var h:int=enemies.length-1;h>=0;h--)
			{
				//kesempatan pada musuh untuk menjatuhkan bomb
				if(enemies[h].chanceAttack)
				{
					var c:Bomb=new Bomb(enemies[h].x,enemies[h].y,7)
					addChild(c);
					bombs.push(c);
				}
				for(var i:int=bullets.length-1;i>=0;i--)
				{
					
					if(bullets[i].hitTestObject(enemies[h]))
					{
						enemyHit++;
						if(enemies[h].currentFrame==1)
						{
							score +=50;
						}
						else if(enemies[h].currentFrame==2)
						{
							score +=75;
						}
						else if(enemies[h].currentFrame==3)
						{
							score +=100;
						}
						enemies[h].deletePlane();
						bullets[i].deleteBullet();
						showGameScore();
						break;
					}
				}
			}
			//cek tumbukan ship_mc dengan bomb
			for(var j:int=0;j<bombs.length;j++)
			{
				if(bombs[j].hitTestObject(ship_mc))
				{
					bombs[j].deleteBomb();
					
					stat="Anda Kalah!!";
					gotoAndStop("gameover");
				}
			}
			if(enemyHit>=20)
			{
				stat="Anda Menang!!";
				gotoAndStop("gameover");
			}
		}
		
		public function removeBullet(bullet:Bullet)
		{
			for(var i in bullets)
			{
				if(bullets[i]==bullet)
				{
					bullets.splice(i,1);
					break;
				}
			}
		}
		public function removeBomb(bomb:Bomb)
		{
			for(var i in bombs)
			{
				if(bombs[i]==bomb)
				{
					bombs.splice(i,1);
					break;
				}
			}
			
		}
		public function removePlane(enemyChild:Enemy)
		{
			for(var i in enemies)
			{
				if(enemies[i]==enemyChild)
				{
					enemies.splice(i,1);
					break;
				}
			}
		}
		
		public function showGameScore()
		{
			gameScore.text=String(score);
			numEnemyHit.text=String(enemyHit);
		}
		public function cleanUp()
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onUp);
			removeEventListener(Event.ENTER_FRAME, onFrame);
			for(var i:int=enemies.length-1;i>=0;i--)
			{
				enemies[i].deletePlane();
			}
			for(var j:int=bullets.length-1;j>=0;j--)
			{
				bullets[j].deleteBullet();
			}
			for(var k:int=bombs.length-1;k>=0;k--)
			{
				bombs[k].deleteBomb();
			}
			
			ship_mc.deleteShip();
			enemies=null;
			timerNewEnemy.stop();
			timerNewEnemy=null;
			leftArrow=false;
			rightArrow=false;
			score=0;
			enemyHit=0;
		}
		
	}
}