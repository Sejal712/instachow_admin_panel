# Pharmacy Category Images Directory

This directory stores images for pharmacy categories.

## Directory Structure:

- `master_cat_pharmacy/` - Main directory for pharmacy category images
- Images are automatically uploaded here when adding/editing pharmacy categories
- File naming convention: `cat_[unique_id].[extension]`

## Supported Image Formats:

- JPG/JPEG
- PNG
- GIF
- WebP

## Usage:

When adding a new pharmacy category through the admin panel, images will be automatically saved to this directory with a unique filename.

## Sample Files:

- `cat_68c91a3bbff994.78506014.jpg` - Sample pharmacy category image
- `cat_68c91a56efa3f9.30895239.png` - Another sample image

## Security:

- Directory listing is disabled
- Only image files are allowed
- CORS headers are properly set for web access
