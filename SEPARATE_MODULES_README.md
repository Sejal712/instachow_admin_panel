# Separate Modules Structure for Food and Grocery Categories

This project now has separate files and services for Food and Grocery categories, ensuring proper image storage in different folders and better code organization.

## 🗂️ File Structure

### PHP Backend Files
- `food_categories.php` - Handles Food category CRUD operations
- `grocery_categories.php` - Handles Grocery category CRUD operations  
- `food_sub_categories.php` - Handles Food sub-category operations
- `grocery_sub_categories.php` - Handles Grocery sub-category operations

### Flutter Frontend Files
- `lib/screens/food_categories_screen.dart` - Food categories management UI
- `lib/screens/grocery_categories_screen.dart` - Grocery categories management UI
- `lib/screens/food_category_edit_screen.dart` - Food category edit UI
- `lib/screens/grocery_category_edit_screen.dart` - Grocery category edit UI
- `lib/screens/food_sub_categories_screen.dart` - Food sub-categories management UI
- `lib/screens/grocery_sub_categories_screen.dart` - Grocery sub-categories management UI

### API Services
- `lib/services/food_api_service.dart` - Food categories and sub-categories API calls
- `lib/services/grocery_api_service.dart` - Grocery categories and sub-categories API calls

### Configuration
- `lib/config/api_config.dart` - Updated with new endpoint URLs

## 🖼️ Image Storage

### Food Categories
- **Upload Folder**: `master_cat_food_img/`
- **File Prefix**: `food_cat_`
- **Example Path**: `master_cat_food_img/food_cat_688e5d4f51d879.30313834.png`

### Grocery Categories  
- **Upload Folder**: `master_cat_grocessory_img/`
- **File Prefix**: `grocery_cat_`
- **Example Path**: `master_cat_grocessory_img/grocery_cat_688e5d4f51d879.30313834.png`

## 🔧 How It Works

### 1. Module Selection
The admin panel allows users to switch between "Food" and "Grocery" modules.

### 2. Dynamic Screen Loading
Based on the selected module, the appropriate screen is loaded:
- **Food Module** → `FoodCategoriesScreen`
- **Grocery Module** → `GroceryCategoriesScreen`

### 3. API Endpoints
Each module uses its dedicated API endpoint:
- Food: `/food_categories.php`
- Grocery: `/grocery_categories.php`

### 4. Image Upload
When adding/editing categories:
- Food images are automatically saved to `master_cat_food_img/`
- Grocery images are automatically saved to `master_cat_grocessory_img/`

## 📱 Usage

### Adding Categories
1. Select the desired module (Food or Grocery)
2. Click on "Categories" in the sidebar
3. Fill in the category name
4. Upload an image (required)
5. Click "Add"

### Editing Categories
1. Navigate to the categories list
2. Click the edit icon on any category
3. Modify the name and/or image
4. Click "Update"

### Deleting Categories
1. Navigate to the categories list
2. Click the delete icon on any category
3. Confirm the deletion

## 🗑️ Removed Files

The following old files have been removed as they're no longer needed:
- `food_category_updated.php` - Replaced by separate module files
- `sub_categories.php` - Replaced by separate module files
- `lib/screens/categories_screen.dart` - Replaced by separate module screens
- `lib/screens/category_edit_screen.dart` - Replaced by separate module screens
- `lib/screens/sub_categories_screen.dart` - Replaced by separate module screens
- `lib/services/api_service.dart` - Replaced by separate module services

## 🔄 Migration Notes

### For Existing Data
- Existing Food categories will continue to work
- Existing Grocery categories will continue to work
- Images are already stored in the correct folders

### For New Development
- Use the appropriate service class for each module
- Images will be automatically stored in the correct folder
- No need to specify the module manually - it's handled automatically

## 🚀 Benefits

1. **Better Organization**: Separate files for each module
2. **Proper Image Storage**: Images stored in module-specific folders
3. **Easier Maintenance**: Clear separation of concerns
4. **Scalability**: Easy to add new modules in the future
5. **Type Safety**: Dedicated services for each module

## 📋 API Endpoints Summary

| Module | Categories | Sub-Categories |
|--------|------------|----------------|
| Food | `/food_categories.php` | `/food_sub_categories.php` |
| Grocery | `/grocery_categories.php` | `/grocery_sub_categories.php` |

## 🔍 Troubleshooting

### Common Issues

1. **Images not uploading**: Check folder permissions for the upload directories
2. **API errors**: Verify the backend files are in the correct location
3. **Module not switching**: Ensure the module selection is working in the admin panel

### Debug Steps

1. Check browser console for JavaScript errors
2. Verify PHP error logs for backend issues
3. Confirm database connections are working
4. Test image upload permissions

## 📞 Support

If you encounter any issues with the new structure, please check:
1. File permissions on upload directories
2. Database connectivity
3. API endpoint accessibility
4. Flutter service imports
