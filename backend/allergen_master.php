<?php
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

require_once 'db.php';

class AllergenMaster {
    private $conn;
    
    public function __construct($conn) {
        $this->conn = $conn;
    }
    
    // Get all allergen items
    public function getAll() {
        try {
            $query = "SELECT * FROM allergen_master ORDER BY name ASC";
            $result = $this->conn->query($query);
            
            if (!$result) {
                return [
                    'success' => false,
                    'message' => 'Database error: ' . $this->conn->error
                ];
            }
            
            $allergens = [];
            while ($row = $result->fetch_assoc()) {
                $allergens[] = $row;
            }
            
            return [
                'success' => true,
                'data' => $allergens
            ];
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error fetching allergen data: ' . $e->getMessage()
            ];
        }
    }
    
    // Add new allergen item
    public function add($name) {
        try {
            $name = $this->conn->real_escape_string($name);
            
            $query = "INSERT INTO allergen_master (name) VALUES (?)";
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
                    'message' => 'Allergen item added successfully',
                    'data' => [
                        'allergen_id' => $this->conn->insert_id,
                        'name' => $name
                    ]
                ];
            } else {
                return [
                    'success' => false,
                    'message' => 'Failed to add allergen item: ' . $stmt->error
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error adding allergen item: ' . $e->getMessage()
            ];
        }
    }
    
    // Update allergen item
    public function update($id, $name) {
        try {
            $name = $this->conn->real_escape_string($name);
            $id = (int)$id;
            
            $query = "UPDATE allergen_master SET name = ? WHERE allergen_id = ?";
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
                    'message' => 'Allergen item updated successfully'
                ];
            } else {
                return [
                    'success' => false,
                    'message' => 'Failed to update allergen item: ' . $stmt->error
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error updating allergen item: ' . $e->getMessage()
            ];
        }
    }
    
    // Delete allergen item
    public function delete($id) {
        try {
            $id = (int)$id;
            
            $query = "DELETE FROM allergen_master WHERE allergen_id = ?";
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
                    'message' => 'Allergen item deleted successfully'
                ];
            } else {
                return [
                    'success' => false,
                    'message' => 'Failed to delete allergen item: ' . $stmt->error
                ];
            }
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error deleting allergen item: ' . $e->getMessage()
            ];
        }
    }
}

$allergen = new AllergenMaster($conn);

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        echo json_encode($allergen->getAll());
        break;
        
    case 'POST':
        $data = json_decode(file_get_contents('php://input'), true);
        $name = $data['name'] ?? '';
        
        if (empty($name)) {
            echo json_encode([
                'success' => false,
                'message' => 'Allergen name is required'
            ]);
        } else {
            echo json_encode($allergen->add($name));
        }
        break;
        
    case 'PUT':
        $data = json_decode(file_get_contents('php://input'), true);
        $id = $data['id'] ?? 0;
        $name = $data['name'] ?? '';
        
        if (empty($id) || empty($name)) {
            echo json_encode([
                'success' => false,
                'message' => 'Allergen ID and name are required'
            ]);
        } else {
            echo json_encode($allergen->update($id, $name));
        }
        break;
        
    case 'DELETE':
        $data = json_decode(file_get_contents('php://input'), true);
        $id = $data['id'] ?? 0;
        
        if (empty($id)) {
            echo json_encode([
                'success' => false,
                'message' => 'Allergen ID is required'
            ]);
        } else {
            echo json_encode($allergen->delete($id));
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