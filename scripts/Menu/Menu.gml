// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function MenuItem(_title, _cost, _image) constructor {
	title = _title;
	cost = _cost;
	image = _image;
	quantityToBuy = 0;
	x = other.x;
	y = other.y;
	buttonDec = instance_create_layer(x, y, "Instances", objButton);
	buttonDec.myStruct = self;
	buttonDec.callback = RemoveFromCart;
	buttonInc = instance_create_layer(x, y, "Instances", objButton);
	buttonInc.myStruct = self;
	buttonInc.callback = AddToCart;
	buttonDec.facing = -1;
	
	static AddToCart = function()
	{
		quantityToBuy += 1;
	}
	
	static RemoveFromCart = function()
	{
		if (quantityToBuy > 0)
			quantityToBuy -=1;
	}
	
	function GetCallback(_callback)
	{
		script_execute(_callback);	
	}
	
	function DrawItem(_x, _y)
	{
		draw_sprite(image, 0, _x, _y);
	}
}

function ShopMenu() constructor {
	shopList = [];
	x = other.x;
	y = other.y;
	subTotal = 0;
	
	static AddItem = function(title, cost, image) {
		item = new MenuItem(title, cost, image);
		shopList[array_length(shopList)] = item;
	}
	
	function updateSubTotal()
	{
		subTotal = 0;
		for ( var i = 0; i < array_length(shopList); i++)
		{
			var currentItem = shopList[i];
			subTotal += currentItem.quantityToBuy * currentItem.cost;
		}
	}
	
	static DrawShopMenu = function() 
	{
		for (var i = 0; i < array_length(shopList); i++)
		{

			var v_spacer = 48;
			var currentItem = shopList[i];
			var y_pos = y + (i * v_spacer);
			currentItem.DrawItem(x, y + (i * v_spacer));
			draw_set_valign(fa_center);
			draw_text(x + 40, y_pos, currentItem.title);
			
			currentItem.buttonDec.x = x + 170;
			currentItem.buttonDec.y = y_pos;
			draw_text(x + 200, y_pos, currentItem.quantityToBuy);
			currentItem.buttonInc.x = x + 240;
			currentItem.buttonInc.y = y_pos;
		}
		
		draw_text(room_width/2, v_spacer * (i + 1), "Subtotal: " + string(subTotal));
	}
}

function DoNothing() {
	
}