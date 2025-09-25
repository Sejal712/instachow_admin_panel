<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

require_once 'db.php';

class PharmacyCategories {
    private $conn;
    
    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }
    
    public function getAll() {
        try {
            $sql = "SELECT * FROM master_categories WHERE module = 'Pharmacy' ORDER BY created_at DESC";
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
    
    public function add($name, $iconUrl = null, $imageFile = null) {
        try {
            // Validate input
            if (empty($name)) {
                throw new Exception("Category name is required");
            }
            
            // Check if category already exists
            $checkSql = "SELECT COUNT(*) as count FROM master_categories WHERE name = ? AND module = 'Pharmacy'";
            $checkStmt = $this->conn->prepare($checkSql);
            $checkStmt->execute([$name]);
            $row = $checkStmt->fetch(PDO::FETCH_ASSOC);
            
            if ($row['count'] > 0) {
                throw new Exception("Pharmacy category with this name already exists");
            }
            
            $imagePath = null;
            
            // Handle image upload if provided
            if ($imageFile && isset($imageFile['tmp_name']) && !empty($imageFile['tmp_name'])) {
                $uploadDir = 'master_cat_pharmacy_img/';
                if (!file_exists($uploadDir)) {
                    mkdir($uploadDir, 0777, true);
                }
                
                $fileExtension = pathinfo($imageFile['name'], PATHINFO_EXTENSION);
                $fileName = 'cat_' . uniqid() . '.' . $fileExtension;
                $uploadPath = $uploadDir . $fileName;
                
                if (move_uploaded_file($imageFile['tmp_name'], $uploadPath)) {
                    $imagePath = $uploadPath;
                } else {
                    throw new Exception("Failed to upload image");
                }
            }
            
            // Insert category
            $sql = "INSERT INTO master_categories (name, icon_url, module, created_at) VALUES (?, ?, 'Pharmacy', NOW())";
            $stmt = $this->conn->prepare($sql);
            
            // Use uploaded image path if available, otherwise use provided icon URL
            $finalIconUrl = $imagePath ?: $iconUrl;
            
            if ($stmt->execute([$name, $finalIconUrl])) {
                $categoryId = $this->conn->lastInsertId();
                
                // Fetch the created category
                $fetchSql = "SELECT * FROM master_categories WHERE maste_cat_food_id = ?";
                $fetchStmt = $this->conn->prepare($fetchSql);
                $fetchStmt->execute([$categoryId]);
                $category = $fetchStmt->fetch(PDO::FETCH_ASSOC);
                
                return [
                    'success' => true,
                    'data' => $category,
                    'message' => 'Pharmacy category added successfully'
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
    
    public function update($id, $name, $imageFile = null) {
        try {
            // Validate input
            if (empty($id) || empty($name)) {
                throw new Exception("Category ID and name are required");
            }
            
            // Check if category exists
            $checkSql = "SELECT * FROM master_categories WHERE maste_cat_food_id = ? AND module = 'Pharmacy'";
            $checkStmt = $this->conn->prepare($checkSql);
            $checkStmt->execute([$id]);
            $currentCategory = $checkStmt->fetch(PDO::FETCH_ASSOC);
            
            if (!$currentCategory) {
                throw new Exception("Pharmacy category not found");
            }
            $imagePath = $currentCategory['icon_url']; // Keep current image by default
            
            // Handle image upload if provided
            if ($imageFile && isset($imageFile['tmp_name']) && !empty($imageFile['tmp_name'])) {
                $uploadDir = 'master_cat_pharmacy_img/';
                if (!file_exists($uploadDir)) {
                    mkdir($uploadDir, 0777, true);
                }
                
                $fileExtension = pathinfo($imageFile['name'], PATHINFO_EXTENSION);
                $fileName = 'cat_' . uniqid() . '.' . $fileExtension;
                $uploadPath = $uploadDir . $fileName;
                
                if (move_uploaded_file($imageFile['tmp_name'], $uploadPath)) {
                    // Delete old image if it exists
                    if ($currentCategory['icon_url'] && file_exists($currentCategory['icon_url'])) {
                        unlink($currentCategory['icon_url']);
                    }
                    $imagePath = $uploadPath;
                } else {
                    throw new Exception("Failed to upload image");
                }
            }
            
            // Update category
            $sql = "UPDATE master_categories SET name = ?, icon_url = ? WHERE maste_cat_food_id = ? AND module = 'Pharmacy'";
            $stmt = $this->conn->prepare($sql);
            
            if ($stmt->execute([$name, $imagePath, $id])) {
                // Fetch the updated category
                $fetchSql = "SELECT * FROM master_categories WHERE maste_cat_food_id = ?";
                $fetchStmt = $this->conn->prepare($fetchSql);
                $fetchStmt->execute([$id]);
                $category = $fetchStmt->fetch(PDO::FETCH_ASSOC);
                
                return [
                    'success' => true,
                    'data' => $category,
                    'message' => 'Pharmacy category updated successfully'
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
                throw new Exception("Category ID is required");
            }
            
            // Check if category exists
            $checkSql = "SELECT * FROM master_categories WHERE maste_cat_food_id = ? AND module = 'Pharmacy'";
            $checkStmt = $this->conn->prepare($checkSql);
            $checkStmt->execute([$id]);
            $category = $checkStmt->fetch(PDO::FETCH_ASSOC);
            
            if (!$category) {
                throw new Exception("Pharmacy category not found");
            }
            
            // Delete image file if it exists
            if ($category['icon_url'] && file_exists($category['icon_url'])) {
                unlink($category['icon_url']);
            }
            
            // Delete category
            $sql = "DELETE FROM master_categories WHERE maste_cat_food_id = ? AND module = 'Pharmacy'";
            $stmt = $this->conn->prepare($sql);
            
            if ($stmt->execute([$id])) {
                return [
                    'success' => true,
                    'data' => null,
                    'message' => 'Pharmacy category deleted successfully'
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
}

// Initialize the class
$pharmacyCategories = new PharmacyCategories();

// Handle the request
$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        echo json_encode($pharmacyCategories->getAll());
        break;
        
    case 'POST':
        $name = $_POST['name'] ?? '';
        $iconUrl = $_POST['icon_url'] ?? null;
        $imageFile = $_FILES['image'] ?? null;
        
        echo json_encode($pharmacyCategories->add($name, $iconUrl, $imageFile));
        break;
        
    case 'PUT':
        // Handle both multipart and JSON requests
        if (isset($_POST['_method']) && $_POST['_method'] === 'PUT') {
            // Multipart request with method override
            $id = $_POST['id'] ?? '';
            $name = $_POST['name'] ?? '';
            $imageFile = $_FILES['image'] ?? null;
        } else {
            // Regular JSON request
            parse_str(file_get_contents("php://input"), $putData);
            $id = $putData['id'] ?? '';
            $name = $putData['name'] ?? '';
            $imageFile = null;
        }
        
        echo json_encode($pharmacyCategories->update($id, $name, $imageFile));
        break;
        
    case 'DELETE':
        $input = file_get_contents("php://input");
        $deleteData = json_decode($input, true);
        $id = $deleteData['id'] ?? $_GET['id'] ?? '';
        
        echo json_encode($pharmacyCategories->delete($id));
        break;
        
    default:
        echo json_encode([
            'success' => false,
            'data' => null,
            'message' => 'Method not allowed'
        ]);
        break;
}
?>
