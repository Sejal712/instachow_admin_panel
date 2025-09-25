<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

require_once 'db.php';

class PharmacySubCategories {
    private $conn;

    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }

    public function getAll() {
        try {
            $sql = "SELECT sc.*, mc.name as main_category_name 
                    FROM sub_categories sc 
                    LEFT JOIN master_categories mc ON sc.master_cat_food_id = mc.maste_cat_food_id 
                    WHERE mc.module = 'Pharmacy' 
                    ORDER BY sc.created_at DESC";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute();

            $subCategories = $stmt->fetchAll(PDO::FETCH_ASSOC);

            return [
                'success' => true,
                'data' => $subCategories,
                'message' => 'Pharmacy sub-categories retrieved successfully'
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'data' => [],
                'message' => $e->getMessage()
            ];
        }
    }

    public function getByCategory($categoryId) {
        try {
            $sql = "SELECT * FROM sub_categories WHERE master_cat_food_id = ? ORDER BY created_at DESC";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute([$categoryId]);

            $subCategories = $stmt->fetchAll(PDO::FETCH_ASSOC);

            return [
                'success' => true,
                'data' => $subCategories,
                'message' => 'Sub-categories retrieved successfully'
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'data' => [],
                'message' => $e->getMessage()
            ];
        }
    }

    public function add($name, $description, $masterCategoryId) {
        try {
            // Validate input
            if (empty($name)) {
                throw new Exception("Sub-category name is required");
            }
            if (empty($masterCategoryId)) {
                throw new Exception("Main category is required");
            }

            // Check if main category exists and is a pharmacy category
            $checkSql = "SELECT * FROM master_categories WHERE maste_cat_food_id = ? AND module = 'Pharmacy'";
            $checkStmt = $this->conn->prepare($checkSql);
            $checkStmt->execute([$masterCategoryId]);
            $mainCategory = $checkStmt->fetch(PDO::FETCH_ASSOC);

            if (!$mainCategory) {
                throw new Exception("Pharmacy category not found");
            }

            // Check if sub-category already exists for this main category
            $duplicateSql = "SELECT COUNT(*) as count FROM sub_categories WHERE name = ? AND master_cat_food_id = ?";
            $duplicateStmt = $this->conn->prepare($duplicateSql);
            $duplicateStmt->execute([$name, $masterCategoryId]);
            $duplicateRow = $duplicateStmt->fetch(PDO::FETCH_ASSOC);

            if ($duplicateRow['count'] > 0) {
                throw new Exception("Sub-category with this name already exists for the selected main category");
            }

            // Insert sub-category
            $sql = "INSERT INTO sub_categories (name, description, master_cat_food_id, created_at) VALUES (?, ?, ?, NOW())";
            $stmt = $this->conn->prepare($sql);

            if ($stmt->execute([$name, $description, $masterCategoryId])) {
                $subCategoryId = $this->conn->lastInsertId();

                // Fetch the created sub-category with main category name
                $fetchSql = "SELECT sc.*, mc.name as main_category_name 
                            FROM sub_categories sc 
                            LEFT JOIN master_categories mc ON sc.master_cat_food_id = mc.maste_cat_food_id 
                            WHERE sc.categories_id = ?";
                $fetchStmt = $this->conn->prepare($fetchSql);
                $fetchStmt->execute([$subCategoryId]);
                $subCategory = $fetchStmt->fetch(PDO::FETCH_ASSOC);

                return [
                    'success' => true,
                    'data' => $subCategory,
                    'message' => 'Pharmacy sub-category added successfully'
                ];
            } else {
                throw new Exception("Execute failed");
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'data' => null,
                'message' => $e->getMessage()
            ];
        }
    }

    public function update($id, $name, $description, $masterCategoryId) {
        try {
            // Validate input
            if (empty($id) || empty($name)) {
                throw new Exception("Sub-category ID and name are required");
            }
            if (empty($masterCategoryId)) {
                throw new Exception("Main category is required");
            }

            // Check if sub-category exists
            $checkSql = "SELECT * FROM sub_categories WHERE categories_id = ?";
            $checkStmt = $this->conn->prepare($checkSql);
            $checkStmt->execute([$id]);
            $currentSubCategory = $checkStmt->fetch(PDO::FETCH_ASSOC);

            if (!$currentSubCategory) {
                throw new Exception("Sub-category not found");
            }

            // Check if main category exists and is a pharmacy category
            $mainCategorySql = "SELECT * FROM master_categories WHERE maste_cat_food_id = ? AND module = 'Pharmacy'";
            $mainCategoryStmt = $this->conn->prepare($mainCategorySql);
            $mainCategoryStmt->execute([$masterCategoryId]);
            $mainCategory = $mainCategoryStmt->fetch(PDO::FETCH_ASSOC);

            if (!$mainCategory) {
                throw new Exception("Pharmacy category not found");
            }

            // Check for duplicate name (excluding current sub-category)
            $duplicateSql = "SELECT COUNT(*) as count FROM sub_categories WHERE name = ? AND master_cat_food_id = ? AND categories_id != ?";
            $duplicateStmt = $this->conn->prepare($duplicateSql);
            $duplicateStmt->execute([$name, $masterCategoryId, $id]);
            $duplicateRow = $duplicateStmt->fetch(PDO::FETCH_ASSOC);

            if ($duplicateRow['count'] > 0) {
                throw new Exception("Sub-category with this name already exists for the selected main category");
            }

            // Update sub-category
            $sql = "UPDATE sub_categories SET name = ?, description = ?, master_cat_food_id = ? WHERE categories_id = ?";
            $stmt = $this->conn->prepare($sql);

            if ($stmt->execute([$name, $description, $masterCategoryId, $id])) {
                // Fetch the updated sub-category with main category name
                $fetchSql = "SELECT sc.*, mc.name as main_category_name 
                            FROM sub_categories sc 
                            LEFT JOIN master_categories mc ON sc.master_cat_food_id = mc.maste_cat_food_id 
                            WHERE sc.categories_id = ?";
                $fetchStmt = $this->conn->prepare($fetchSql);
                $fetchStmt->execute([$id]);
                $subCategory = $fetchStmt->fetch(PDO::FETCH_ASSOC);

                return [
                    'success' => true,
                    'data' => $subCategory,
                    'message' => 'Pharmacy sub-category updated successfully'
                ];
            } else {
                throw new Exception("Execute failed");
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'data' => null,
                'message' => $e->getMessage()
            ];
        }
    }

    public function delete($id) {
        try {
            // Validate input
            if (empty($id)) {
                throw new Exception("Sub-category ID is required");
            }

            // Check if sub-category exists
            $checkSql = "SELECT sc.*, mc.name as main_category_name 
                        FROM sub_categories sc 
                        LEFT JOIN master_categories mc ON sc.master_cat_food_id = mc.maste_cat_food_id 
                        WHERE sc.categories_id = ? AND mc.module = 'Pharmacy'";
            $checkStmt = $this->conn->prepare($checkSql);
            $checkStmt->execute([$id]);
            $subCategory = $checkStmt->fetch(PDO::FETCH_ASSOC);

            if (!$subCategory) {
                throw new Exception("Pharmacy sub-category not found");
            }

            // Delete sub-category
            $sql = "DELETE FROM sub_categories WHERE categories_id = ?";
            $stmt = $this->conn->prepare($sql);

            if ($stmt->execute([$id])) {
                return [
                    'success' => true,
                    'data' => null,
                    'message' => 'Pharmacy sub-category deleted successfully'
                ];
            } else {
                throw new Exception("Execute failed");
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'data' => null,
                'message' => $e->getMessage()
            ];
        }
    }

    public function getMainCategories() {
        try {
            $sql = "SELECT * FROM master_categories WHERE module = 'Pharmacy' ORDER BY name ASC";
            $stmt = $this->conn->prepare($sql);
            $stmt->execute();

            $categories = $stmt->fetchAll(PDO::FETCH_ASSOC);

            return [
                'success' => true,
                'data' => $categories,
                'message' => 'Pharmacy categories retrieved successfully'
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'data' => [],
                'message' => $e->getMessage()
            ];
        }
    }
}

// Initialize the class
$pharmacySubCategories = new PharmacySubCategories();

// Handle the request
$method = $_SERVER['REQUEST_METHOD'];
$response = [];

switch ($method) {
    case 'GET':
        if (isset($_GET['category_id'])) {
            $response = $pharmacySubCategories->getByCategory($_GET['category_id']);
        } elseif (isset($_GET['main_categories'])) {
            $response = $pharmacySubCategories->getMainCategories();
        } else {
            $response = $pharmacySubCategories->getAll();
        }
        break;

    case 'POST':
        $data = json_decode(file_get_contents('php://input'), true);
        $name = $data['name'] ?? '';
        $description = $data['description'] ?? '';
        $masterCategoryId = $data['master_category_id'] ?? '';
        
        $response = $pharmacySubCategories->add($name, $description, $masterCategoryId);
        break;

    case 'PUT':
        $data = json_decode(file_get_contents('php://input'), true);
        $id = $data['id'] ?? '';
        $name = $data['name'] ?? '';
        $description = $data['description'] ?? '';
        $masterCategoryId = $data['master_category_id'] ?? '';
        
        $response = $pharmacySubCategories->update($id, $name, $description, $masterCategoryId);
        break;

    case 'DELETE':
        $data = json_decode(file_get_contents('php://input'), true);
        $id = $data['id'] ?? '';
        
        $response = $pharmacySubCategories->delete($id);
        break;

    default:
        $response = [
            'success' => false,
            'message' => 'Method not allowed'
        ];
        break;
}

echo json_encode($response);
?>
