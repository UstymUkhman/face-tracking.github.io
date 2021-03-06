vec4 verticalBlur (sampler2D diffuse, vec2 uv, float amount) {
  vec4 sum = vec4(0.0);

  sum += texture(diffuse, vec2(uv.x, uv.y - 4.0 * amount)) * 0.051;
  sum += texture(diffuse, vec2(uv.x, uv.y - 3.0 * amount)) * 0.0918;
  sum += texture(diffuse, vec2(uv.x, uv.y - 2.0 * amount)) * 0.12245;
  sum += texture(diffuse, vec2(uv.x, uv.y - 1.0 * amount)) * 0.1531;

  sum += texture(diffuse, vec2(uv.x, uv.y)) * 0.1633;

  sum += texture(diffuse, vec2(uv.x, uv.y + 1.0 * amount)) * 0.1531;
  sum += texture(diffuse, vec2(uv.x, uv.y + 2.0 * amount)) * 0.12245;
  sum += texture(diffuse, vec2(uv.x, uv.y + 3.0 * amount)) * 0.0918;
  sum += texture(diffuse, vec2(uv.x, uv.y + 4.0 * amount)) * 0.051;

  return sum;
}

vec4 horizontalBlur (sampler2D diffuse, vec2 uv, float amount) {
  vec4 sum = vec4(0.0);

  sum += texture(diffuse, vec2(uv.x - 4.0 * amount, uv.y)) * 0.051;
  sum += texture(diffuse, vec2(uv.x - 3.0 * amount, uv.y)) * 0.0918;
  sum += texture(diffuse, vec2(uv.x - 2.0 * amount, uv.y)) * 0.12245;
  sum += texture(diffuse, vec2(uv.x - 1.0 * amount, uv.y)) * 0.1531;

  sum += texture(diffuse, vec2(uv.x, uv.y)) * 0.1633;

  sum += texture(diffuse, vec2(uv.x + 1.0 * amount, uv.y)) * 0.1531;
  sum += texture(diffuse, vec2(uv.x + 2.0 * amount, uv.y)) * 0.12245;
  sum += texture(diffuse, vec2(uv.x + 3.0 * amount, uv.y)) * 0.0918;
  sum += texture(diffuse, vec2(uv.x + 4.0 * amount, uv.y)) * 0.051;

  return sum;
}

vec4 blur (sampler2D diffuse, vec4 mask, vec2 uv, float strength) {
  vec4 color = texture(diffuse, uv);

  if (uvInMask(mask, uv)) {
    vec4 hBlur = horizontalBlur(diffuse, uv, strength);
    vec4 vBlur = verticalBlur(diffuse, uv, strength);

    color.r = (color.r + hBlur.r + vBlur.r) / 3.0;
    color.g = (color.g + hBlur.g + vBlur.g) / 3.0;
    color.b = (color.b + hBlur.b + vBlur.b) / 3.0;
  }

  return color;
}
