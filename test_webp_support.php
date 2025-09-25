<?php
// Test WebP support
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Handle preflight OPTIONS request
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit(0);
}

// Check GD library WebP support
$gd_info = gd_info();
$webp_supported = isset($gd_info['WebP Support']) && $gd_info['WebP Support'];

// Check allowed file types
$allowed_types = ['jpg', 'jpeg', 'png', 'gif', 'webp'];

echo json_encode([
    'success' => true,
    'message' => 'WebP Support Test',
    'data' => [
        'gd_webp_support' => $webp_supported,
        'allowed_file_types' => $allowed_types,
        'php_version' => phpversion(),
        'gd_version' => $gd_info['GD Version'] ?? 'Not available',
        'webp_functions' => [
            'imagecreatefromwebp' => function_exists('imagecreatefromwebp'),
            'imagewebp' => function_exists('imagewebp'),
        ],
        'upload_max_filesize' => ini_get('upload_max_filesize'),
        'post_max_size' => ini_get('post_max_size'),
    ]
]);
?>
