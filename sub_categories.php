<?php
require_once 'db.php';

$database = new Database();
$db = $database->getConnection();

$method = $_SERVER['REQUEST_METHOD'];

// Handle method override for multipart requests
if ($method === 'POST' && isset($_POST['_method'])) {
    $method = $_POST['_method'];
}

switch($method) {
    case 'GET':
        getSubCategories($db);
        break;
    case 'POST':
        addSubCategory($db);
        break;
    case 'PUT':
        updateSubCategory($db);
        break;
    case 'DELETE':
        deleteSubCategory($db);
        break;
    default:
        sendResponse(false, 'Method not allowed');
        break;
}

function getSubCategories($db) {
    try {
        // Get master category ID filter from query parameter
        $masterCatId = $_GET['master_cat_id'] ?? null;
        
        if ($masterCatId) {
            // Get sub-categories for a specific master category
            $query = "SELECT sc.categories_id, sc.name, sc.description, sc.created_at, sc.master_cat_food_id, mc.name as master_category_name 
                     FROM sub_categories sc 
                     LEFT JOIN master_categories mc ON sc.master_cat_food_id = mc.maste_cat_food_id 
                     WHERE sc.master_cat_food_id = :master_cat_id 
                     ORDER BY sc.created_at DESC";
            $stmt = $db->prepare($query);
            $stmt->bindParam(':master_cat_id', $masterCatId);
        } else {
            // Get all sub-categories with master category names
            $query = "SELECT sc.categories_id, sc.name, sc.description, sc.created_at, sc.master_cat_food_id, mc.name as master_category_name 
                     FROM sub_categories sc 
                     LEFT JOIN master_categories mc ON sc.master_cat_food_id = mc.maste_cat_food_id 
                     ORDER BY sc.created_at DESC";
            $stmt = $db->prepare($query);
        }
        
        $stmt->execute();
        
        $subCategories = [];
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $subCategories[] = [
                'id' => $row['categories_id'],
                'name' => $row['name'],
                'description' => $row['description'],
                'master_cat_food_id' => $row['master_cat_food_id'],
                'master_category_name' => $row['master_category_name'],
                'created_at' => $row['created_at']
            ];
        }
        
        sendResponse(true, 'Sub-categories retrieved successfully', $subCategories);
        
    } catch(PDOException $e) {
        sendResponse(false, 'Error retrieving sub-categories: ' . $e->getMessage());
    }
}

function addSubCategory($db) {
    try {
        // Get data from POST request
        $name = $_POST['name'] ?? '';
        $description = $_POST['description'] ?? '';
        $masterCatId = $_POST['master_cat_food_id'] ?? '';
        
        // Validate required fields
        if (empty($name) || empty($masterCatId)) {
            sendResponse(false, 'Name and Master Category are required');
            return;
        }
        
        // Check if master category exists
        $checkQuery = "SELECT maste_cat_food_id FROM master_categories WHERE maste_cat_food_id = :master_cat_id";
        $checkStmt = $db->prepare($checkQuery);
        $checkStmt->bindParam(':master_cat_id', $masterCatId);
        $checkStmt->execute();
        
        if ($checkStmt->rowCount() == 0) {
            sendResponse(false, 'Master category does not exist');
            return;
        }
        
        // Check if sub-category name already exists for this master category
        $duplicateQuery = "SELECT categories_id FROM sub_categories WHERE name = :name AND master_cat_food_id = :master_cat_id";
        $duplicateStmt = $db->prepare($duplicateQuery);
        $duplicateStmt->bindParam(':name', $name);
        $duplicateStmt->bindParam(':master_cat_id', $masterCatId);
        $duplicateStmt->execute();
        
        if ($duplicateStmt->rowCount() > 0) {
            sendResponse(false, 'Sub-category with this name already exists for this master category');
            return;
        }
        
        // Insert new sub-category
        $query = "INSERT INTO sub_categories (name, description, master_cat_food_id, created_at) VALUES (:name, :description, :master_cat_id, NOW())";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':master_cat_id', $masterCatId);
        
        if ($stmt->execute()) {
            $newId = $db->lastInsertId();
            sendResponse(true, 'Sub-category added successfully', ['id' => $newId]);
        } else {
            sendResponse(false, 'Failed to add sub-category');
        }
        
    } catch(PDOException $e) {
        sendResponse(false, 'Error adding sub-category: ' . $e->getMessage());
    }
}

function updateSubCategory($db) {
    try {
        // Parse input for PUT request
        $input = [];
        if ($_SERVER['CONTENT_TYPE'] && strpos($_SERVER['CONTENT_TYPE'], 'multipart/form-data') !== false) {
            // Handle multipart form data for PUT requests
            $input = $_POST;
        } else {
            // Handle JSON input
            $json = file_get_contents('php://input');
            $input = json_decode($json, true);
        }
        
        $id = $input['id'] ?? '';
        $name = $input['name'] ?? '';
        $description = $input['description'] ?? '';
        $masterCatId = $input['master_cat_food_id'] ?? '';
        
        // Validate required fields
        if (empty($id) || empty($name) || empty($masterCatId)) {
            sendResponse(false, 'ID, Name and Master Category are required');
            return;
        }
        
        // Check if sub-category exists
        $checkQuery = "SELECT categories_id FROM sub_categories WHERE categories_id = :id";
        $checkStmt = $db->prepare($checkQuery);
        $checkStmt->bindParam(':id', $id);
        $checkStmt->execute();
        
        if ($checkStmt->rowCount() == 0) {
            sendResponse(false, 'Sub-category not found');
            return;
        }
        
        // Check if master category exists
        $masterCheckQuery = "SELECT maste_cat_food_id FROM master_categories WHERE maste_cat_food_id = :master_cat_id";
        $masterCheckStmt = $db->prepare($masterCheckQuery);
        $masterCheckStmt->bindParam(':master_cat_id', $masterCatId);
        $masterCheckStmt->execute();
        
        if ($masterCheckStmt->rowCount() == 0) {
            sendResponse(false, 'Master category does not exist');
            return;
        }
        
        // Check for duplicate name (excluding current record)
        $duplicateQuery = "SELECT categories_id FROM sub_categories WHERE name = :name AND master_cat_food_id = :master_cat_id AND categories_id != :id";
        $duplicateStmt = $db->prepare($duplicateQuery);
        $duplicateStmt->bindParam(':name', $name);
        $duplicateStmt->bindParam(':master_cat_id', $masterCatId);
        $duplicateStmt->bindParam(':id', $id);
        $duplicateStmt->execute();
        
        if ($duplicateStmt->rowCount() > 0) {
            sendResponse(false, 'Sub-category with this name already exists for this master category');
            return;
        }
        
        // Update sub-category
        $query = "UPDATE sub_categories SET name = :name, description = :description, master_cat_food_id = :master_cat_id WHERE categories_id = :id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':name', $name);
        $stmt->bindParam(':description', $description);
        $stmt->bindParam(':master_cat_id', $masterCatId);
        $stmt->bindParam(':id', $id);
        
        if ($stmt->execute()) {
            sendResponse(true, 'Sub-category updated successfully');
        } else {
            sendResponse(false, 'Failed to update sub-category');
        }
        
    } catch(PDOException $e) {
        sendResponse(false, 'Error updating sub-category: ' . $e->getMessage());
    }
}

function deleteSubCategory($db) {
    try {
        // Get ID from query parameter or JSON input
        $id = $_GET['id'] ?? null;
        
        if (!$id) {
            $json = file_get_contents('php://input');
            $data = json_decode($json, true);
            $id = $data['id'] ?? null;
        }
        
        if (empty($id)) {
            sendResponse(false, 'Sub-category ID is required');
            return;
        }
        
        // Check if sub-category exists
        $checkQuery = "SELECT categories_id FROM sub_categories WHERE categories_id = :id";
        $checkStmt = $db->prepare($checkQuery);
        $checkStmt->bindParam(':id', $id);
        $checkStmt->execute();
        
        if ($checkStmt->rowCount() == 0) {
            sendResponse(false, 'Sub-category not found');
            return;
        }
        
        // Delete sub-category
        $query = "DELETE FROM sub_categories WHERE categories_id = :id";
        $stmt = $db->prepare($query);
        $stmt->bindParam(':id', $id);
        
        if ($stmt->execute()) {
            sendResponse(true, 'Sub-category deleted successfully');
        } else {
            sendResponse(false, 'Failed to delete sub-category');
        }
        
    } catch(PDOException $e) {
        sendResponse(false, 'Error deleting sub-category: ' . $e->getMessage());
    }
}

// Function to get master categories for dropdown
function getMasterCategories($db) {
    try {
        $query = "SELECT maste_cat_food_id, name FROM master_categories ORDER BY name ASC";
        $stmt = $db->prepare($query);
        $stmt->execute();
        
        $categories = [];
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
            $categories[] = [
                'id' => $row['maste_cat_food_id'],
                'name' => $row['name']
            ];
        }
        
        return $categories;
        
    } catch(PDOException $e) {
        return [];
    }
}
?>
