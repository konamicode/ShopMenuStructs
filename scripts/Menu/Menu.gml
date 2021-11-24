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
	buttonInc = instance_create_layer(x, y, "Instances", objButton);
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
	currentIndex = 0;
	var menu = self;
	btnPurchase = instance_create_layer(x, y, "Instances", objButton);
	btnPurchase.sprite_index = sprButtonPurchase;
	btnPurchase.callback = Purchase;
	static AddItem = function(title, cost, image) {
		item = new MenuItem(title, cost, image);
		shopList[array_length(shopList)] = item;
		var _index = array_length(shopList);
		item.buttonDec.callback = Remove;
		item.buttonDec.shopIndex = _index - 1;
		item.buttonInc.callback = Add;
		item.buttonInc.shopIndex = _index - 1;
	}
	
	function updateSubTotal()
	{
		subTotal = 0;
		for ( var i = 0; i < array_length(shopList); i++)
		{
			var currentIndex = shopList[i];
			subTotal += currentIndex.quantityToBuy * currentIndex.cost;
		}
	}
	
	static MenuDown = function() {
		if ((currentIndex + 1) < array_length(shopList))
			currentIndex += 1;
		else
			currentIndex = 0;
			
	}
	
	static MenuUp = function() {
		if (currentIndex == 0)
			currentIndex = array_length(shopList);
		else
			currentIndex -= 1;
	
	}
	
	static Add = function(_index) {
		var item = shopList[_index];
		item.AddToCart();
	}
	
	static Remove = function(_index) {
		var item = shopList[_index];
		item.RemoveFromCart();
	}
	
	static DrawShopMenu = function() 
	{
		for (var i = 0; i < array_length(shopList); i++)
		{

			var v_spacer = 48;
			var _item = shopList[i];
			var y_pos = y + (i * v_spacer);
			_item.DrawItem(x, y + (i * v_spacer));
			draw_set_valign(fa_center);
			var c = draw_get_color();
			if (i == currentIndex)
				draw_set_color(c_white)
			else
				draw_set_color(c_black)
			draw_text(x + 40, y_pos, _item.title);
			draw_set_color(c);
			_item.buttonDec.x = x + 170;
			_item.buttonDec.y = y_pos;

			draw_text(x + 200, y_pos, _item.quantityToBuy);
			_item.buttonInc.x = x + 240;
			_item.buttonInc.y = y_pos;
		}
		
		draw_text(room_width/2, v_spacer * (i + 1), "Subtotal: " + string(subTotal));
		btnPurchase.x = room_width/2;
		btnPurchase.y = v_spacer * (i + 3);
		draw_text(room_width/2, v_spacer * (i + 3), "Purchase");
	}
	
	static Purchase = function()
	{
		//deduct cost and add to ship inventory
		show_debug_message("I bought a thing for : " + string(subTotal) + "!");
	}
	
	function GetCallback(_func, _param) {
		_func(_param);	
	}
}

function DoNothing() {
	return 0;
}