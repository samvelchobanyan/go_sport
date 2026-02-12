#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uSize;
uniform float uTime;
uniform vec4 uColors[12];

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;
    float ratio = uSize.x / uSize.y;
    vec2 p = uv;
    p.x *= ratio;

    // Чистый белый фон
    vec3 backgroundColor = vec3(1.0, 1.0, 1.0); 
    
    vec3 layerColor = vec3(0.0);
    float totalWeight = 0.0;

    float progress = sin(uTime * 0.3) * 0.5 + 0.5;

    for (int i = 0; i < 6; i++) {
        float fI = float(i);
        
        vec2 posA = vec2(0.2 * ratio + fI * 0.12, 0.25 + sin(fI) * 0.3);
        vec2 posB = vec2(0.8 * ratio - fI * 0.12, 0.75 - cos(fI) * 0.3);
        
        vec2 currentPos = mix(posA, posB, progress);
        // Легкое хаотичное покачивание
        currentPos += vec2(sin(uTime * 0.15 + fI) * 0.03, cos(uTime * 0.2 + fI) * 0.03);

        for (int j = 0; j < 2; j++) {
            float fJ = float(j);
            vec2 offset = vec2(0.1 * sin(uTime * 0.4 + fJ * 2.0), 0.1 * cos(uTime * 0.4 + fJ * 2.0));
            vec2 d = p - (currentPos + offset);

            // Форма кляксы
            float stretch = 0.8 + 0.2 * fract(sin(fI * 45.0 + fJ));
            float dist = length(d * stretch);
            
            // СУПЕР-МЯГКОЕ РАЗМЫТИЕ
            // Увеличили радиус (1.5) и степень (3.0) для прозрачности
            float weight = smoothstep(1.5, 0.0, dist * 1.5);
            weight = pow(weight, 3.0); 

            layerColor += uColors[i * 2 + j].rgb * weight;
            totalWeight += weight;
        }
    }

    // РЕГУЛИРОВКА ПРОЗРАЧНОСТИ
    // Коэффициент 0.4 делает цвета в два раза бледнее и прозрачнее
    float transparencyFactor = clamp(totalWeight * 0.4, 0.0, 0.5);
    
    // Смешиваем белый фон с цветами клякс
    vec3 finalRgb = mix(backgroundColor, layerColor / (totalWeight + 0.001), transparencyFactor);

    fragColor = vec4(finalRgb, 1.0);
}