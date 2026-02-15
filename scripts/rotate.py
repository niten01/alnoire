import os
import sys
from PIL import Image, ImageOps
from pathlib import Path

directory = Path(os.path.abspath(sys.argv[0])).parent.parent / "content/models/mgtu/materials/textures/people/student/textures"

for filename in os.listdir(directory):
    if filename.lower().endswith(('.png', '.jpg', '.jpeg', '.tiff', '.bmp')):
        filepath = os.path.join(directory, filename)
        with Image.open(filepath) as img:
            # rotated_img = img.rotate(180, expand=True)
            rotated_img = ImageOps.flip(img)
            rotated_img.save(filepath)