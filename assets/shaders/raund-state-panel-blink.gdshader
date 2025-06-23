shader_type canvas_item;

uniform float speed = 3.0;          // Частота мерцания (2-5)
uniform float intensity = 0.3;      // Сила эффекта (0.1-0.5)
//uniform vec4 highlight_color = vec4(1.5, 0.4, 0.4, 1.0); // красный
uniform vec4 highlight_color = vec4(1.3, 0.6, 0.6, 1.0); // светло красный
//uniform vec4 highlight_color = vec4(1.5, 0.8, 0.8, 1.0); // белый
//uniform vec4 highlight_color = vec4(0.5, 1.5, 0.5, 1.0); // Яркий зелёный

void fragment() {
    // Получаем исходный цвет текстуры
    vec4 tex_color = texture(TEXTURE, UV);
    
    // Плавное пульсирующее значение (0-1)
    float pulse = (sin(TIME * speed) + 1.0) * 0.5; 
    
    // Смешиваем с цветом подсветки
    vec3 blended_color = mix(tex_color.rgb, highlight_color.rgb, pulse * intensity);
    
    // Сохраняем оригинальную прозрачность
    COLOR = vec4(blended_color, tex_color.a);
}