/// @description Insert description here
// You can write your code in this editor

shopMenu.updateSubTotal();


if keyboard_check_pressed(vk_down)
	shopMenu.MenuDown();
	
if keyboard_check_pressed(vk_up)
	shopMenu.MenuUp();
	
if keyboard_check_pressed(vk_left)
	shopMenu.Remove(shopMenu.currentIndex);
	
if keyboard_check_pressed(vk_right)
	shopMenu.Add(shopMenu.currentIndex);