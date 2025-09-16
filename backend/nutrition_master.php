<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

require_once 'db.php';

class NutritionMaster {
    private $conn;
    
    public function __construct($conn) {
        $this->conn = $conn;
    }
    
    // Get all nutrition items
    public function getAll() {
        try {
            $query = "SELECT * FROM nutrition_master ORDER BY name ASC";
            $result = $this->conn->query($query);
            
            if (!$result) {
                return [
                    'success' => false,
                    'message' => 'Database error: ' . $this->conn->error
                ];
            }
            
            $nutrition = [];
            while ($row = $result->fetch_assoc()) {
                $nutrition[] = $row;
            }
            
            return [
                'success' => true,
                'data' => $nutrition
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error fetching nutrition data: ' . $e->getMessage()
            ];
        }
    }
    
    // Add new nutrition item
    public function add($name) {
        try {
            $name = $this->conn->real_escape_string($name);
            
            $query = "INSERT INTO nutrition_master (name) VALUES (?)";
            $stmt = $this->conn->prepare($query);
            if (!$stmt) {
                return [
                    'success' => false,
                    'message' => 'Database error: ' . $this->conn->error
                ];
            }
            
            $stmt->bind_param("s", $name);
            
            if ($stmt->execute()) {
                return [
                    'success' => true,
                    'message' => 'Nutrition item added successfully',
                    'data' => [
                        'nutrition_id' => $this->conn->insert_id,
                        'name' => $name
                    ]
                ];
            } else {
                return [
                    'success' => false,
                    'message' => 'Failed to add nutrition item: ' . $stmt->error
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error adding nutrition item: ' . $e->getMessage()
            ];
        }
    }
    
    // Update nutrition item
    public function update($id, $name) {
        try {
            $name = $this->conn->real_escape_string($name);
            $id = (int)$id;
            
            $query = "UPDATE nutrition_master SET name = ? WHERE nutrition_id = ?";
            $stmt = $this->conn->prepare($query);
            if (!$stmt) {
                return [
                    'success' => false,
                    'message' => 'Database error: ' . $this->conn->error
                ];
            }
            
            $stmt->bind_param("si", $name, $id);
            
            if ($stmt->execute()) {
                return [
                    'success' => true,
                    'message' => 'Nutrition item updated successfully'
                ];
            } else {
                return [
                    'success' => false,
                    'message' => 'Failed to update nutrition item: ' . $stmt->error
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error updating nutrition item: ' . $e->getMessage()
            ];
        }
    }
    
    // Delete nutrition item
    public function delete($id) {
        try {
            $id = (int)$id;
            
            $query = "DELETE FROM nutrition_master WHERE nutrition_id = ?";
            $stmt = $this->conn->prepare($query);
            if (!$stmt) {
                return [
                    'success' => false,
                    'message' => 'Database error: ' . $this->conn->error
                ];
            }
            
            $stmt->bind_param("i", $id);
            
            if ($stmt->execute()) {
                return [
                    'success' => true,
                    'message' => 'Nutrition item deleted successfully'
                ];
            } else {
                return [
                    'success' => false,
                    'message' => 'Failed to delete nutrition item: ' . $stmt->error
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error deleting nutrition item: ' . $e->getMessage()
            ];
        }
    }
}

$nutrition = new NutritionMaster($conn);

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        echo json_encode($nutrition->getAll());
        break;
        
    case 'POST':
        $data = json_decode(file_get_contents('php://input'), true);
        $name = $data['name'] ?? '';
        
        if (empty($name)) {
            echo json_encode([
                'success' => false,
                'message' => 'Nutrition name is required'
            ]);
        } else {
            echo json_encode($nutrition->add($name));
        }
        break;
        
    case 'PUT':
        $data = json_decode(file_get_contents('php://input'), true);
        $id = $data['id'] ?? 0;
        $name = $data['name'] ?? '';
        
        if (empty($id) || empty($name)) {
            echo json_encode([
                'success' => false,
                'message' => 'Nutrition ID and name are required'
            ]);
        } else {
            echo json_encode($nutrition->update($id, $name));
        }
        break;
        
    case 'DELETE':
        $data = json_decode(file_get_contents('php://input'), true);
        $id = $data['id'] ?? 0;
        
        if (empty($id)) {
            echo json_encode([
                'success' => false,
                'message' => 'Nutrition ID is required'
            ]);
        } else {
            echo json_encode($nutrition->delete($id));
        }
        break;
        
    default:
        echo json_encode([
            'success' => false,
            'message' => 'Method not allowed'
        ]);
        break;
}
?> 