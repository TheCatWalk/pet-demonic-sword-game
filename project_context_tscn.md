# [Feed The Sword] Project Context File: .tscn

## res://

### scenes

**bubble.tscn**
```ini
[gd_scene format=3 uid="uid://ck3ms4ncapggs"]

[ext_resource type="Texture2D" uid="uid://dgx3s17dnqoe4" path="res://assets/bubble/Bubble/bubble.png" id="1_2vdav"]
[ext_resource type="Script" uid="uid://dkgks0gcs4lnb" path="res://scripts/bubble.gd" id="2_pm753"]
[ext_resource type="Script" uid="uid://e5n6g7h266gx" path="res://scripts/sound_chomp.gd" id="3_b4vvx"]
[ext_resource type="AudioStream" uid="uid://baumfylghpkl0" path="res://assets/audio/audio_bubbles_1.ogg" id="4_ax11v"]
[ext_resource type="AudioStream" uid="uid://fty5wfqfpvh7" path="res://assets/audio/audio_bubbles_2.ogg" id="5_8ycye"]
[ext_resource type="AudioStream" uid="uid://csivu2kljif7" path="res://assets/audio/audio_bubbles_3.ogg" id="6_6jlkr"]

[node name="bubble" type="CPUParticles2D" unique_id=864270088]
texture = ExtResource("1_2vdav")
lifetime = 2.0
explosiveness = 0.56
randomness = 0.4
lifetime_randomness = 0.31
direction = Vector2(0, -1)
spread = 30.79
gravity = Vector2(0, 0)
initial_velocity_min = 20.0
initial_velocity_max = 100.0
damping_min = 5.921
damping_max = 26.974
scale_amount_min = 0.25
scale_amount_max = 2.0
script = ExtResource("2_pm753")

[node name="sound_bubble" type="AudioStreamPlayer2D" parent="." unique_id=8164126]
volume_db = -25.839
script = ExtResource("3_b4vvx")
sounds = Array[AudioStream]([ExtResource("4_ax11v"), ExtResource("5_8ycye"), ExtResource("6_6jlkr")])

[node name="Timer" type="Timer" parent="." unique_id=679108074]

```

**food.tscn**
```ini
[gd_scene format=3 uid="uid://cjwu5caouwots"]

[ext_resource type="Script" uid="uid://k5q42ea8a2xh" path="res://scripts/food.gd" id="1_af40f"]
[ext_resource type="Texture2D" uid="uid://4nifjej2syy4" path="res://assets/food/meats/pixel-meats-60/tbone-steak.png" id="1_xven1"]
[ext_resource type="Script" uid="uid://cfd6w0wjyb8ty" path="res://scenes/sound_drop.gd" id="3_370ap"]
[ext_resource type="AudioStream" uid="uid://cq4d7ypplsn8o" path="res://assets/audio/audio_bubble.ogg" id="4_qjm1k"]

[sub_resource type="CircleShape2D" id="CircleShape2D_xven1"]
radius = 24.020824

[node name="food" type="CharacterBody2D" unique_id=188966436]
script = ExtResource("1_af40f")

[node name="TboneSteak2" type="Sprite2D" parent="." unique_id=43782751]
scale = Vector2(0.75, 0.75)
texture = ExtResource("1_xven1")

[node name="CollisionShape2D" type="CollisionShape2D" parent="." unique_id=833101611]
position = Vector2(-2, 1)
shape = SubResource("CircleShape2D_xven1")
disabled = true

[node name="Timer" type="Timer" parent="." unique_id=1289094684]
wait_time = 0.1
one_shot = true
autostart = true

[node name="sound_drop" type="AudioStreamPlayer2D" parent="." unique_id=1877776765]
script = ExtResource("3_370ap")
sounds = Array[AudioStream]([ExtResource("4_qjm1k")])

```

**sword.tscn**
```ini
[gd_scene format=3 uid="uid://csvs8daxl78ib"]

[ext_resource type="Script" uid="uid://bx1j41mbkmg03" path="res://scripts/sword.gd" id="1_n355p"]
[ext_resource type="Texture2D" uid="uid://cg4ldudcq64pb" path="res://assets/swords/sword_01_centred_cropped.png" id="2_p4x8v"]
[ext_resource type="Texture2D" uid="uid://b0v7lx1uwgwaq" path="res://assets/swords/sword_03_centred_cropped.png" id="2_s4ec8"]
[ext_resource type="Script" uid="uid://btwtrwmiyfkgw" path="res://scripts/sword_sprite.gd" id="3_s4ec8"]
[ext_resource type="Script" uid="uid://cy0fauicqjaru" path="res://scripts/sword_area.gd" id="4_k5whp"]
[ext_resource type="AudioStream" uid="uid://08i4ru2fnvj6" path="res://assets/audio/audio_chomp_1.ogg" id="5_1yp6w"]
[ext_resource type="Texture2D" uid="uid://dy36mifyc88l3" path="res://assets/swords/sword_04_centred_cropped.png" id="5_3oqan"]
[ext_resource type="Script" uid="uid://e5n6g7h266gx" path="res://scripts/sound_chomp.gd" id="6_fnw8x"]
[ext_resource type="Texture2D" uid="uid://duk8ljn3v440r" path="res://assets/swords/sword_05_centred_cropped.png" id="6_sjcpw"]
[ext_resource type="AudioStream" uid="uid://1djte44kydnl" path="res://assets/audio/audio_chomp_2.ogg" id="7_cp3m4"]
[ext_resource type="Script" uid="uid://bvol6us60gsyj" path="res://scripts/random_position.gd" id="11_3oqan"]
[ext_resource type="AudioStream" uid="uid://cepxjtdlyv5gx" path="res://assets/audio/audio_pop.ogg" id="11_sjcpw"]

[sub_resource type="CircleShape2D" id="CircleShape2D_s4ec8"]
radius = 15.0

[node name="sword" type="CharacterBody2D" unique_id=1045126170]
script = ExtResource("1_n355p")

[node name="sword_sprite" type="Sprite2D" parent="." unique_id=1885588746 node_paths=PackedStringArray("sword_area", "sound_pop")]
scale = Vector2(0.25, 0.25)
texture = ExtResource("2_p4x8v")
script = ExtResource("3_s4ec8")
sword_area = NodePath("../sword_area")
images = Array[CompressedTexture2D]([ExtResource("2_s4ec8"), ExtResource("5_3oqan"), ExtResource("6_sjcpw")])
sound_pop = NodePath("../sound_pop")

[node name="sword_area" type="Area2D" parent="." unique_id=1040540972 node_paths=PackedStringArray("sound_chomp", "sword_sprite")]
script = ExtResource("4_k5whp")
sound_chomp = NodePath("../sound_chomp")
sword_sprite = NodePath("../sword_sprite")

[node name="CollisionShape2D" type="CollisionShape2D" parent="sword_area" unique_id=1734053575]
shape = SubResource("CircleShape2D_s4ec8")

[node name="sound_chomp" type="AudioStreamPlayer2D" parent="." unique_id=667205689]
stream = ExtResource("5_1yp6w")
script = ExtResource("6_fnw8x")
sounds = Array[AudioStream]([ExtResource("5_1yp6w"), ExtResource("7_cp3m4")])

[node name="sound_pop" type="AudioStreamPlayer2D" parent="." unique_id=1988410756]
script = ExtResource("6_fnw8x")
sounds = Array[AudioStream]([ExtResource("11_sjcpw")])

[node name="random_position" type="Timer" parent="." unique_id=1383127507]
autostart = true
script = ExtResource("11_3oqan")

```

**swordbowl.tscn**
```ini
[gd_scene format=3 uid="uid://cl0bp48oawp3c"]

[ext_resource type="Texture2D" uid="uid://do8o2ujm325ht" path="res://assets/fishbowl/fishbowl-back.png" id="1_yppm6"]
[ext_resource type="Script" uid="uid://si67dpiucc1f" path="res://scripts/food_container.gd" id="2_160m0"]
[ext_resource type="PackedScene" uid="uid://csvs8daxl78ib" path="res://scenes/sword.tscn" id="2_sm2eq"]
[ext_resource type="Texture2D" uid="uid://b4bw4shxm0xc2" path="res://assets/fishbowl/fishbowl-front.png" id="2_yq0v6"]
[ext_resource type="Texture2D" uid="uid://5hqnmn7m1h26" path="res://assets/fishbowl/water-button-mask.png" id="4_sm2eq"]
[ext_resource type="Texture2D" uid="uid://cqiohtj5vftn0" path="res://assets/decorations-red/halloween pumpkins/pumpkins-outline.png" id="5_hh614"]
[ext_resource type="Script" uid="uid://cxkl2f0fgj1ia" path="res://scripts/water_button.gd" id="5_ll3wk"]
[ext_resource type="Shader" uid="uid://bh10a8xql5crr" path="res://shaders/foliage.tres" id="5_lp3pk"]
[ext_resource type="Texture2D" uid="uid://dc0pxlfbjqv7n" path="res://assets/decorations-red/Graveyard/Graveyard_Set.png" id="5_wgxn2"]
[ext_resource type="Texture2D" uid="uid://d1luao0hcrtp7" path="res://assets/decorations-red/FancyMansion_Furniture/fancy_mansion_furnitureset_withshadow.png" id="6_lp3pk"]
[ext_resource type="Script" uid="uid://cy0t40hunjluv" path="res://scripts/fishbowl_button.gd" id="7_a8hem"]
[ext_resource type="Texture2D" uid="uid://bk7hha3jxowvy" path="res://assets/fishbowl/bowl-button-mask.png" id="7_piyae"]
[ext_resource type="Script" uid="uid://borgoayefar43" path="res://scripts/resize_button.gd" id="9_1xn47"]
[ext_resource type="PackedScene" uid="uid://ck3ms4ncapggs" path="res://scenes/bubble.tscn" id="10_6mvqw"]
[ext_resource type="Script" uid="uid://dca63p2n6h2t0" path="res://scripts/tooltip.gd" id="10_qv3t7"]
[ext_resource type="Texture2D" uid="uid://myoooe623v35" path="res://assets/bubble/Bubble/24_Pixels006.png" id="11_fdxaj"]
[ext_resource type="Texture2D" uid="uid://cv4v4yv0exu4j" path="res://assets/ui/IconGodotNode/node_3D/icon_area_meteo.png" id="11_s4kht"]
[ext_resource type="Texture2D" uid="uid://5ea7r1ioqava" path="res://assets/bubble/Bubble/24_Pixels007.png" id="12_d2j15"]
[ext_resource type="Texture2D" uid="uid://djg24m5c2csyc" path="res://assets/ui/IconGodotNode/node_3D/icon_move.png" id="12_g1tto"]
[ext_resource type="Texture2D" uid="uid://dlnf1vphkc5lx" path="res://assets/bubble/Bubble/24_Pixels008.png" id="13_6f0id"]
[ext_resource type="Texture2D" uid="uid://cm6grj2f0ably" path="res://assets/ui/IconGodotNode/node_3D/icon_paused.png" id="13_gqfgq"]
[ext_resource type="Texture2D" uid="uid://b5fwlbjop6cr5" path="res://assets/bubble/Bubble/24_Pixels009.png" id="14_4sm5s"]
[ext_resource type="Texture2D" uid="uid://dg7f436fd44v1" path="res://assets/ui/IconGodotNode/node_3D/icon_play.png" id="14_hh614"]
[ext_resource type="Texture2D" uid="uid://dmwc6mhr8ou3l" path="res://assets/ui/IconGodotNode/node_3D/icon_heart.png" id="15_g1tto"]
[ext_resource type="Script" uid="uid://bns0vmpiopmip" path="res://scripts/mute_button.gd" id="16_gqfgq"]
[ext_resource type="Script" uid="uid://e5n6g7h266gx" path="res://scripts/sound_chomp.gd" id="26_d2j15"]
[ext_resource type="AudioStream" uid="uid://djny1svd04vsr" path="res://assets/audio/audio_glass_slide_1.ogg" id="27_siao6"]
[ext_resource type="AudioStream" uid="uid://b01af5f1cmkqa" path="res://assets/audio/audio_glass_slide_2.ogg" id="28_cvxmx"]
[ext_resource type="AudioStream" uid="uid://cf0oi3qnu7o66" path="res://assets/audio/audio_glass_slide_3.ogg" id="29_moe7a"]
[ext_resource type="AudioStream" uid="uid://bgcjkr5yh2jqi" path="res://assets/audio/audio_glass_slide_4.ogg" id="30_iqb7n"]
[ext_resource type="AudioStream" uid="uid://cfus2iwxncamh" path="res://assets/audio/audio_glass_place_1.ogg" id="31_wcoob"]
[ext_resource type="AudioStream" uid="uid://bke34e36jwqhj" path="res://assets/audio/audio_glass_place_2.ogg" id="32_h4txo"]
[ext_resource type="AudioStream" uid="uid://b6wup2jws8dwa" path="res://assets/audio/audio_glass_place_3.ogg" id="33_fa3ed"]
[ext_resource type="AudioStream" uid="uid://f8c15xb4vy13" path="res://assets/audio/audio_glass_place_4.ogg" id="34_q2nlx"]

[sub_resource type="ShaderMaterial" id="ShaderMaterial_wgxn2"]
shader = ExtResource("5_lp3pk")
shader_parameter/x_intensity = 0.5
shader_parameter/y_intensity = 3.0
shader_parameter/offset = 0.0
shader_parameter/speed = 1.562000074195
shader_parameter/wave_frequency = 20.0
shader_parameter/wave_length = 200.0

[sub_resource type="ShaderMaterial" id="ShaderMaterial_6mvqw"]
shader = ExtResource("5_lp3pk")
shader_parameter/x_intensity = 5.0
shader_parameter/y_intensity = 2.0
shader_parameter/offset = 0.0
shader_parameter/speed = 2.0
shader_parameter/wave_frequency = 20.0
shader_parameter/wave_length = 200.0

[sub_resource type="ShaderMaterial" id="ShaderMaterial_lp3pk"]
shader = ExtResource("5_lp3pk")
shader_parameter/x_intensity = 0.0
shader_parameter/y_intensity = 2.0
shader_parameter/offset = 0.0
shader_parameter/speed = 2.0
shader_parameter/wave_frequency = 20.0
shader_parameter/wave_length = 200.0

[node name="swordbowl" type="Node2D" unique_id=1241587242]

[node name="fishbowl-button" type="TextureButton" parent="." unique_id=802616504 node_paths=PackedStringArray("sound_glass_slide", "sound_glass_place")]
self_modulate = Color(1, 1, 1, 0)
offset_left = -518.0
offset_top = -532.0
offset_right = 521.0
offset_bottom = 528.0
texture_normal = ExtResource("7_piyae")
script = ExtResource("7_a8hem")
sound_glass_slide = NodePath("../sound_glass_slide")
sound_glass_place = NodePath("../sound_glass_place")

[node name="swordbowl-back" type="Sprite2D" parent="." unique_id=908641235]
texture = ExtResource("1_yppm6")

[node name="decor" type="Node2D" parent="." unique_id=1817024848]

[node name="tree2" type="Sprite2D" parent="decor" unique_id=64807619]
position = Vector2(-177.02301, 49.09539)
scale = Vector2(5.138158, 5.1381583)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(343, 368, 51, 81)

[node name="tree1" type="Sprite2D" parent="decor" unique_id=282640920]
position = Vector2(175.00002, 60.000004)
scale = Vector2(5.6096487, 5.609649)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(242, 366, 57, 83)

[node name="grass1" type="Sprite2D" parent="decor" unique_id=355404875]
material = SubResource("ShaderMaterial_wgxn2")
position = Vector2(205.00002, 207)
scale = Vector2(5.6096487, 5.609649)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(290, 449, 28, 31)

[node name="grass2" type="Sprite2D" parent="decor" unique_id=481299980]
material = SubResource("ShaderMaterial_6mvqw")
position = Vector2(-301, 202.00002)
rotation = -0.6681927
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(290, 449, 28, 31)

[node name="bookshelf1" type="Sprite2D" parent="decor" unique_id=91612967]
position = Vector2(4.7683716e-07, 163)
rotation = 0.008175861
scale = Vector2(3.9782608, 3.9782608)
texture = ExtResource("6_lp3pk")
region_enabled = true
region_rect = Rect2(2, 250, 44, 72)

[node name="fruitpainting2" type="Sprite2D" parent="decor" unique_id=676094354]
position = Vector2(252, -141)
rotation = 0.008175861
scale = Vector2(1.8950659, 1.8057885)
texture = ExtResource("6_lp3pk")
region_enabled = true
region_rect = Rect2(192, 66, 32, 28)

[node name="fruitpainting1" type="Sprite2D" parent="decor" unique_id=760929173]
position = Vector2(289, 130)
rotation = 0.008175861
scale = Vector2(1.8950659, 1.8057885)
texture = ExtResource("6_lp3pk")
region_enabled = true
region_rect = Rect2(192, 66, 32, 28)

[node name="flowerpainting1" type="Sprite2D" parent="decor" unique_id=1840792377]
position = Vector2(142.00002, -123)
rotation = 0.008175861
scale = Vector2(1.8950659, 1.8057885)
texture = ExtResource("6_lp3pk")
region_enabled = true
region_rect = Rect2(167, 69, 18, 22)

[node name="flowerpainting3" type="Sprite2D" parent="decor" unique_id=754616299]
position = Vector2(133, -13)
rotation = 0.008175861
scale = Vector2(1.8950659, 1.8057885)
texture = ExtResource("6_lp3pk")
region_enabled = true
region_rect = Rect2(167, 69, 18, 22)

[node name="flowerpainting2" type="Sprite2D" parent="decor" unique_id=1022673593]
position = Vector2(326, 46)
rotation = 0.008175861
scale = Vector2(1.8950659, 1.8057885)
texture = ExtResource("6_lp3pk")
region_enabled = true
region_rect = Rect2(167, 69, 18, 22)

[node name="pumpkin2" type="Sprite2D" parent="decor" unique_id=1659092082]
position = Vector2(117, 267)
scale = Vector2(3.617647, 3.8017247)
texture = ExtResource("5_hh614")
region_enabled = true
region_rect = Rect2(160, 191, 34, 34)

[node name="pumpkin3" type="Sprite2D" parent="decor" unique_id=1410949169]
position = Vector2(199, 265)
scale = Vector2(3.617647, 3.8017247)
texture = ExtResource("5_hh614")
region_enabled = true
region_rect = Rect2(95, 95, 34, 31)

[node name="grass3" type="Sprite2D" parent="decor" unique_id=892149280]
material = SubResource("ShaderMaterial_lp3pk")
position = Vector2(95.00001, 325)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(224, 465, 15, 15)

[node name="grass4" type="Sprite2D" parent="decor" unique_id=2034769270]
material = SubResource("ShaderMaterial_lp3pk")
position = Vector2(61.000008, 315)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(224, 465, 15, 15)

[node name="grass5" type="Sprite2D" parent="decor" unique_id=828125673]
material = SubResource("ShaderMaterial_lp3pk")
position = Vector2(61, 336)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(224, 465, 15, 15)

[node name="grass6" type="Sprite2D" parent="decor" unique_id=1938314954]
material = SubResource("ShaderMaterial_lp3pk")
position = Vector2(94, 355.00003)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(224, 465, 15, 15)

[node name="grass7" type="Sprite2D" parent="decor" unique_id=996004691]
material = SubResource("ShaderMaterial_lp3pk")
position = Vector2(216.00002, 317)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(224, 465, 15, 15)

[node name="grass8" type="Sprite2D" parent="decor" unique_id=236071968]
material = SubResource("ShaderMaterial_lp3pk")
position = Vector2(43.000015, 350.00003)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(224, 465, 15, 15)

[node name="grass9" type="Sprite2D" parent="decor" unique_id=1576412235]
material = SubResource("ShaderMaterial_lp3pk")
position = Vector2(66, 355.99997)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(224, 465, 15, 15)

[node name="bones1" type="Sprite2D" parent="decor" unique_id=1315680669]
position = Vector2(154, 288)
rotation = -0.46932417
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(144, 352, 16, 15)

[node name="eyes2" type="Sprite2D" parent="decor" unique_id=82913401]
position = Vector2(-170.00002, 21.000002)
rotation = -0.020037055
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(372, 465, 8, 14)

[node name="eyes1" type="Sprite2D" parent="decor" unique_id=1141966027]
position = Vector2(195.00005, 86)
rotation = -0.020037057
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(403, 450, 7, 29)

[node name="eyes3" type="Sprite2D" parent="decor" unique_id=820440885]
position = Vector2(-174, 58)
rotation = -0.020037055
scale = Vector2(2.0025997, 2.0025995)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(357, 465, 6, 14)

[node name="bones2" type="Sprite2D" parent="decor" unique_id=1926020896]
position = Vector2(35, 30)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(130, 352, 13, 15)

[node name="bones3" type="Sprite2D" parent="decor" unique_id=256415474]
position = Vector2(-27, 20.000002)
rotation = 0.011555015
scale = Vector2(3.7333953, 3.7333953)
texture = ExtResource("5_wgxn2")
region_enabled = true
region_rect = Rect2(145, 313, 13, 22)

[node name="pumpkin1" type="Sprite2D" parent="decor" unique_id=1195948025]
position = Vector2(168, 330)
scale = Vector2(3.6176472, 3.801725)
texture = ExtResource("5_hh614")
region_enabled = true
region_rect = Rect2(0, 194, 34, 29)

[node name="pumpkin4" type="Sprite2D" parent="decor" unique_id=1036719755]
position = Vector2(59, 369.00003)
scale = Vector2(2.6004903, 2.5162485)
texture = ExtResource("5_hh614")
region_enabled = true
region_rect = Rect2(36, 132, 24, 26)

[node name="pumpkin5" type="Sprite2D" parent="decor" unique_id=924736723]
position = Vector2(110, 372)
scale = Vector2(2.6004903, 2.5162485)
texture = ExtResource("5_hh614")
region_enabled = true
region_rect = Rect2(69, 132, 21, 25)

[node name="couch1" type="Sprite2D" parent="decor" unique_id=1383041762]
position = Vector2(-173.00002, 233)
rotation = 0.41058624
scale = Vector2(3.9782608, 3.9782608)
texture = ExtResource("6_lp3pk")
region_enabled = true
region_rect = Rect2(1, 180, 63, 46)

[node name="food_container" type="Node2D" parent="." unique_id=1459091898]
position = Vector2(-537, -552)
script = ExtResource("2_160m0")

[node name="sword" parent="." unique_id=1045126170 instance=ExtResource("2_sm2eq")]
position = Vector2(0, -1)

[node name="bubbles" type="Node2D" parent="." unique_id=201727072]

[node name="bubble" parent="bubbles" unique_id=864270088 instance=ExtResource("10_6mvqw")]
position = Vector2(151, 272)

[node name="bubble2" parent="bubbles" unique_id=440527981 instance=ExtResource("10_6mvqw")]
position = Vector2(-300, 221)
image = ExtResource("11_fdxaj")

[node name="bubble3" parent="bubbles" unique_id=639860912 instance=ExtResource("10_6mvqw")]
position = Vector2(38, 53)
image = ExtResource("12_d2j15")

[node name="bubble4" parent="bubbles" unique_id=2049470766 instance=ExtResource("10_6mvqw")]
position = Vector2(-166, 46)
image = ExtResource("13_6f0id")

[node name="bubble5" parent="bubbles" unique_id=215775536 instance=ExtResource("10_6mvqw")]
position = Vector2(50, 295)
image = ExtResource("14_4sm5s")

[node name="swordbowl-front" type="Sprite2D" parent="." unique_id=2009693963]
texture = ExtResource("2_yq0v6")

[node name="water-button" type="TextureButton" parent="." unique_id=244522826]
self_modulate = Color(1, 1, 1, 0)
offset_left = -537.0
offset_top = -552.0
offset_right = 502.0
offset_bottom = 508.0
texture_normal = ExtResource("4_sm2eq")
script = ExtResource("5_ll3wk")

[node name="resize-button" type="Button" parent="." unique_id=147203056]
self_modulate = Color(1, 1, 1, 0)
offset_left = 207.0
offset_top = 357.0
offset_right = 311.0
offset_bottom = 457.0
script = ExtResource("9_1xn47")

[node name="mute-button" type="Button" parent="." unique_id=686216863]
self_modulate = Color(1, 1, 1, 0)
offset_left = -233.0
offset_top = -472.0
offset_right = -127.0
offset_bottom = -360.0
toggle_mode = true
script = ExtResource("16_gqfgq")

[node name="tooltip" type="Sprite2D" parent="." unique_id=516088472]
position = Vector2(-109, 95)
scale = Vector2(2.7500002, 2.7500002)
script = ExtResource("10_qv3t7")
images = Array[CompressedTexture2D]([ExtResource("11_s4kht"), ExtResource("12_g1tto"), ExtResource("13_gqfgq"), ExtResource("14_hh614"), ExtResource("15_g1tto")])

[node name="sound_glass_slide" type="AudioStreamPlayer2D" parent="." unique_id=2136359437]
script = ExtResource("26_d2j15")
sounds = Array[AudioStream]([ExtResource("27_siao6"), ExtResource("28_cvxmx"), ExtResource("29_moe7a"), ExtResource("30_iqb7n")])

[node name="sound_glass_place" type="AudioStreamPlayer2D" parent="." unique_id=1282610348]
script = ExtResource("26_d2j15")
sounds = Array[AudioStream]([ExtResource("31_wcoob"), ExtResource("32_h4txo"), ExtResource("33_fa3ed"), ExtResource("34_q2nlx")])

```

**world.tscn**
```ini
[gd_scene format=3 uid="uid://c6r16h5bv21o4"]

[ext_resource type="PackedScene" uid="uid://cl0bp48oawp3c" path="res://scenes/swordbowl.tscn" id="1_nnsk1"]
[ext_resource type="Script" uid="uid://bc3hjypbtu16" path="res://scripts/world.gd" id="1_rwgxs"]

[node name="world" type="Node2D" unique_id=2063660062]
script = ExtResource("1_rwgxs")

[node name="swordbowl" parent="." unique_id=1241587242 instance=ExtResource("1_nnsk1")]
position = Vector2(506, 553)

```

