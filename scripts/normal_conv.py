from PIL import Image
import numpy as np

# inputs
x_path = "b.png"    
y_path = "g.png"    

# options
invert_green = False  # set True if bumps/dents are inverted in-engine

x_img = Image.open(x_path).convert("L")
y_img = Image.open(y_path).convert("RGBA")  # so we can reliably grab G

if x_img.size != y_img.size:
    raise ValueError("Images must be the same resolution")

# X from grayscale, Y from green channel
x = np.asarray(x_img, dtype=np.float32) / 255.0
y = np.asarray(y_img, dtype=np.float32)[..., 1] / 255.0  # G channel

# map [0,1] -> [-1,1]
x = x * 2.0 - 1.0
y = y * 2.0 - 1.0

if invert_green:
    y = -y

# reconstruct Z, clamp for safety
z2 = 1.0 - (x * x + y * y)
z2 = np.clip(z2, 0.0, 1.0)
z = np.sqrt(z2)

# map [-1,1] -> [0,1]
r = (x + 1.0) * 0.5
g = (y + 1.0) * 0.5
b = (z + 1.0) * 0.5

out = np.stack([r, g, b], axis=-1)
out = np.clip(out * 255.0, 0, 255).astype(np.uint8)

Image.fromarray(out, mode="RGB").save("normal_conventional.png")
print("Wrote normal_conventional.png")
