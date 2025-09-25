# Backend Setup Instructions

## Directory Structure
The PHP backend files should be placed in:
```
C:\xampp\htdocs\instachow_admin_panel_backend\
```

## Files to Copy
Copy these files from the Flutter project to `C:\xampp\htdocs\instachow_admin_panel_backend\`:

### Core Files:
1. `db.php` - Database connection and helper functions
2. `food_categories.php` - Food master categories API
3. `grocery_categories.php` - Grocery master categories API  
4. `food_sub_categories.php` - Food sub-categories API
5. `grocery_sub_categories.php` - Grocery sub-categories API
6. `test_backend.php` - Test file to verify backend is working

## Database Setup
1. Import the `instachow (9).sql` file into MySQL
2. Database name: `instachow`
3. Username: `root`
4. Password: (empty)

## Image Upload Directories
Create these directories in `C:\xampp\htdocs\instachow_admin_panel_backend\`:
- `master_cat_food_img/` - For Food category images
- `master_cat_grocessory_img/` - For Grocery category images

## API Endpoints
The Flutter app will access these endpoints:
- `http://localhost/instachow_admin_panel_backend/food_categories.php`
- `http://localhost/instachow_admin_panel_backend/grocery_categories.php`
- `http://localhost/instachow_admin_panel_backend/food_sub_categories.php`
- `http://localhost/instachow_admin_panel_backend/grocery_sub_categories.php`

## Testing Steps
1. **Test Backend Connection:**
   - Start XAMPP (Apache + MySQL)
   - Visit: `http://localhost/instachow_admin_panel_backend/test_backend.php`
   - Should return JSON response with success message

2. **Test WebP Support:**
   - Visit: `http://localhost/instachow_admin_panel_backend/test_webp_support.php`
   - Should show WebP support status and GD library information

3. **Test Database Connection:**
   - Visit: `http://localhost/instachow_admin_panel_backend/food_categories.php`
   - Should return JSON response (may be empty array if no categories exist)

4. **Test Flutter App:**
   - Run the Flutter app
   - Test both Food and Grocery modules
   - Test image upload with WebP files

## Troubleshooting
- **FormatException errors**: Usually caused by PHP errors being output as HTML
- **404 errors**: Check that files are in correct XAMPP directory
- **Database errors**: Verify database name and connection settings
- **CORS errors**: Headers are already configured in PHP files
- **WebP upload errors**: Check GD library WebP support using test_webp_support.php
- **File upload errors**: Verify upload_max_filesize and post_max_size in php.ini

## Notes
- All PHP files have been updated to use correct database schema
- Error reporting is suppressed to prevent HTML output
- Database connection points to `instachow` database
- Image upload paths are module-specific (Food vs Grocery)
- CORS headers are configured for Flutter app access
- **WebP Support**: Both backend and frontend support WebP image uploads
- **File Types**: JPG, JPEG, PNG, GIF, and WebP are supported
- **File Size Limit**: Maximum 5MB per image upload
