# [Feed The Sword] Project Context File: .tres

## res://

### resources

#### actors

**evolution_stage_1.tres**
```ini
[gd_resource type="EvolutionData" load_steps=3 format=3 uid="uid://evodata001s1a"]

[ext_resource type="Texture2D" uid="uid://b0v7lx1uwgwaq" path="res://assets/swords/sword_03_centred_cropped.png" id="1_sprite"]
[ext_resource type="AudioStream" uid="uid://cepxjtdlyv5gx" path="res://assets/audio/audio_pop.ogg" id="2_sfx"]

[resource]
sprite = ExtResource("1_sprite")
scale_multiplier = 1.0
threshold_value = 10
evolution_sfx = ExtResource("2_sfx")

```

**evolution_stage_2.tres**
```ini
[gd_resource type="EvolutionData" format=3 uid="uid://1ahordrgtxbi"]

[ext_resource type="Texture2D" uid="uid://dy36mifyc88l3" path="res://assets/swords/sword_04_centred_cropped.png" id="1_sprite"]
[ext_resource type="AudioStream" uid="uid://cepxjtdlyv5gx" path="res://assets/audio/audio_pop.ogg" id="2_sfx"]

[resource]
sprite = ExtResource("1_sprite")
scale_multiplier = 1.1
threshold_value = 20
evolution_sfx = ExtResource("2_sfx")

```

**evolution_stage_3.tres**
```ini
[gd_resource type="EvolutionData" format=3 uid="uid://1ahordrgtxci"]

[ext_resource type="Texture2D" uid="uid://duk8ljn3v440r" path="res://assets/swords/sword_05_centred_cropped.png" id="1_sprite"]
[ext_resource type="AudioStream" uid="uid://cepxjtdlyv5gx" path="res://assets/audio/audio_pop.ogg" id="2_sfx"]

[resource]
sprite = ExtResource("1_sprite")
scale_multiplier = 1.2
threshold_value = 30
evolution_sfx = ExtResource("2_sfx")

```

**sword_evolution_main.tres**
```ini
[gd_resource type="ActorManifest" format=3 uid="uid://dg2a0eqsk7iy7"]

[ext_resource type="EvolutionData" uid="uid://evodata001s1a" path="res://resources/actors/evolution_stage_1.tres" id="1_s1"]
[ext_resource type="EvolutionData" uid="uid://1ahordrgtxbi" path="res://resources/actors/evolution_stage_2.tres" id="2_s2"]
[ext_resource type="EvolutionData" uid="uid://evodata001s3a" path="res://resources/actors/evolution_stage_3.tres" id="3_s3"]

[resource]
stages = Array[EvolutionData]([ExtResource("1_s1"), ExtResource("2_s2"), ExtResource("3_s3")])

```

#### items

**item_beef_steak.tres**
```ini
[gd_resource type="ItemData" load_steps=3 format=3 uid="uid://ibeefstk0001a"]

[ext_resource type="PackedScene" uid="uid://cjwu5caouwots" path="res://scenes/collectables/collectable_beef_steak.tscn" id="1_scene"]
[ext_resource type="AudioStream" uid="uid://cq4d7ypplsn8o" path="res://assets/audio/audio_bubble.ogg" id="2_sfx"]

[resource]
name = "Beef Steak"
scene = ExtResource("1_scene")
value = 1
sfx = ExtResource("2_sfx")

```

**item_main.tres**
```ini
[gd_resource type="ItemRegistry" format=3 uid="uid://3kvlal343wii"]

[ext_resource type="ItemData" uid="uid://ibeefstk0001a" path="res://resources/items/item_beef_steak.tres" id="1_beef"]
[ext_resource type="ItemData" uid="uid://isalmnstk001a" path="res://resources/items/item_salmon_steak.tres" id="2_salm"]
[ext_resource type="ItemData" uid="uid://ichicken0001a" path="res://resources/items/item_roast_chicken.tres" id="3_chkn"]

[resource]
items = Array[ItemData]([ExtResource("1_beef"), ExtResource("2_salm"), ExtResource("3_chkn")])

```

**item_roast_chicken.tres**
```ini
[gd_resource type="ItemData" format=3 uid="uid://lnq5gj5vmaiq"]

[ext_resource type="PackedScene" uid="uid://cf4ojjraxkolw" path="res://scenes/collectables/collectable_roast_chicken.tscn" id="1_scene"]
[ext_resource type="AudioStream" uid="uid://cq4d7ypplsn8o" path="res://assets/audio/audio_bubble.ogg" id="2_sfx"]

[resource]
name = "Roast Chicken"
scene = ExtResource("1_scene")
value = 1
sfx = ExtResource("2_sfx")

```

**item_salmon_steak.tres**
```ini
[gd_resource type="ItemData" format=3 uid="uid://2gugjycgmaiq"]

[ext_resource type="PackedScene" uid="uid://dugy6krxqgh8k" path="res://scenes/collectables/collectable_salmon_steak.tscn" id="1_scene"]
[ext_resource type="AudioStream" uid="uid://cq4d7ypplsn8o" path="res://assets/audio/audio_bubble.ogg" id="2_sfx"]

[resource]
name = "Salmon Steak"
scene = ExtResource("1_scene")
value = 1
sfx = ExtResource("2_sfx")

```

### shaders

**foliage.tres**
```ini
[gd_resource type="Shader" format=3 uid="uid://bh10a8xql5crr"]

[resource]
code = "shader_type canvas_item;

uniform float x_intensity = 3.0;
uniform float y_intensity = 0.5;
uniform float offset = 0.0;
uniform float speed : hint_range(0, 20) = 2.0;
uniform float wave_frequency : hint_range(0, 100) = 20;
uniform float wave_length : hint_range(50, 800) = 200.0;

void fragment() {
	vec2 real_uv = vec2(UV.x, UV.y);
	
	vec2 vecToBottom = vec2(1, 1) - UV.y; 
	float distToBottom = length(vecToBottom);
	
	float final_speed = TIME * (speed / 4.0) + offset;
	
	float time_var = (cos(final_speed) * cos(final_speed * 4.0) * cos(final_speed * 2.0))/(200.0);
	float time_var2 = (cos(final_speed) * cos(final_speed * 6.0) * cos(final_speed * 2.0))/(200.0);
	
	float wave_from_x = (cos(real_uv.x * 100.0)/1000.0);
	float wave_large_from_x = cos(TIME + (real_uv.x * wave_frequency))/wave_length;
	
	float wave_from_y = (cos(real_uv.y * 99000.0)/90000.0);
	
	float new_x = real_uv.x + time_var * (distToBottom * x_intensity) + wave_from_x + (wave_large_from_x);
	float new_y = real_uv.y + time_var2 * (distToBottom * y_intensity);
	
	vec2 new_uv1 = vec2(new_x, new_y);
	vec4 new_texture = texture(TEXTURE, new_uv1);
	
	if(new_texture.rgb != vec3(1,1,1)){
		COLOR.rgba = new_texture.rgba;
	}
}"

```

