# Nutrition & Allergen Ingredients Management

This feature allows administrators to manage nutrition and allergen ingredients for food products in the admin panel.

## Features

### Nutrition Management

- View all nutrition items in a list
- Add new nutrition items
- Edit existing nutrition items
- Delete nutrition items
- Search and filter nutrition data

### Allergen Management

- View all allergen items in a list
- Add new allergen items
- Edit existing allergen items
- Delete allergen items
- Search and filter allergen data

## Database Tables

### nutrition_master

```sql
CREATE TABLE nutrition_master (
  nutrition_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

### allergen_master

```sql
CREATE TABLE allergen_master (
  allergen_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

## Files Created/Modified

### Backend Files

- `nutrition_master.php` - PHP API for nutrition CRUD operations
- `allergen_master.php` - PHP API for allergen CRUD operations
- `nutrition_master.sql` - SQL script to create nutrition table with sample data
- `allergen_master.sql` - SQL script to create allergen table with sample data

### Frontend Files

- `lib/screens/nutrition_allergen_screen.dart` - Flutter screen for managing nutrition and allergens
- `lib/services/api_service.dart` - Added API methods for nutrition and allergen operations
- `lib/config/api_config.dart` - Added API endpoints for nutrition and allergen
- `lib/widgets/sidebar.dart` - Added menu item for Nutrition & Allergen Ingredients
- `lib/widgets/main_content.dart` - Added routing for the new screen

## API Endpoints

### Nutrition Master

- `GET /nutrition_master.php` - Get all nutrition items
- `POST /nutrition_master.php` - Add new nutrition item
- `PUT /nutrition_master.php` - Update nutrition item
- `DELETE /nutrition_master.php` - Delete nutrition item

### Allergen Master

- `GET /allergen_master.php` - Get all allergen items
- `POST /allergen_master.php` - Add new allergen item
- `PUT /allergen_master.php` - Update allergen item
- `DELETE /allergen_master.php` - Delete allergen item

## Usage

1. **Access the Feature**: Navigate to "Product Management" → "Add Nutrition & Allergen Ingredients" in the sidebar
2. **Switch Between Tabs**: Use the tabs to switch between Nutrition and Allergens management
3. **Add New Items**: Click "Add Nutrition" or "Add Allergen" buttons
4. **Edit Items**: Click the edit icon next to any item
5. **Delete Items**: Click the delete icon next to any item (with confirmation)

## Sample Data

The SQL files include sample data for common nutrition and allergen items:

### Nutrition Items

- Protein, Carbohydrates, Fat, Fiber, Sugar
- Vitamins (A, C, D, E, K, B-complex)
- Minerals (Calcium, Iron, Potassium, Magnesium, etc.)

### Allergen Items

- Common allergens (Milk, Eggs, Fish, Shellfish, Tree Nuts, Peanuts, Wheat, Soybeans)
- Food additives and sweeteners
- Preservatives and stabilizers

## Setup Instructions

1. **Database Setup**: Run the SQL scripts to create tables and sample data
2. **Backend Setup**: Ensure PHP files are in the correct directory
3. **Frontend Setup**: The Flutter files are already integrated into the project
4. **API Configuration**: Verify the API endpoints in `api_config.dart`

## Error Handling

The feature includes comprehensive error handling:

- Network error messages
- Validation for required fields
- Confirmation dialogs for deletions
- Loading states during API calls
- Success/error notifications

## Future Enhancements

- Bulk import/export functionality
- Search and filter capabilities
- Category organization for nutrition/allergen items
- Integration with product management
- Nutritional value calculations
- Allergen warning systems
