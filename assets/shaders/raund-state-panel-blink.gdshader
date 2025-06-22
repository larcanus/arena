shader_type canvas_item;

// Настройки эффекта
uniform float speed = 3.0;          // Скорость мерцания
uniform float intensity = 0.3;      // Сила эффекта (0-1)
uniform vec4 base_color : source_color = vec4(1.0); // Базовый цвет текстуры

void fragment() {
    // Получаем исходный цвет пикселя
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Генерация пульсации через синусоиду
    float pulse = sin(TIME * speed) * intensity;
    
    // Усиливаем красный канал при мерцании
    vec3 blink_color = tex_color.rgb * (1.0 + pulse * vec3(2.0, 0.5, 0.5));
    
    // Комбинируем с прозрачностью
    COLOR = vec4(blink_color, tex_color.a);
}