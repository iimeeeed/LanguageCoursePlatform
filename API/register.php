<?php
// Include database connection file
include './DatabaseConnection/connection.php';

// Check if the request method is POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get the raw POST data
    $data = json_decode(file_get_contents("php://input"), true);

    // Extract the name and username from the data
    $name = isset($data['name']) ? $data['name'] : '';
    $username = isset($data['username']) ? $data['username'] : '';

    // Initialize response array
    $response = array('status' => 'error', 'message' => 'Invalid input.');

    // Check if name and username are not empty
    if (!empty($name) && !empty($username)) {
        // Prepare SQL query to insert data into the database
        $sql = "INSERT INTO users (name, username) VALUES ('$name', '$username')";

        if ($conn->query($sql) === TRUE) {
            $response = array('status' => 'success', 'message' => 'User registered successfully.');
        } else {
            $response = array('status' => 'error', 'message' => 'Failed to register user: ' . $conn->error);
        }
    } else {
        $response = array('status' => 'error', 'message' => 'Name and username cannot be empty.');
    }

    // Send JSON response
    header('Content-Type: application/json');
    echo json_encode($response);
} else {
    // Method not allowed
    header('HTTP/1.1 405 Method Not Allowed');
    echo json_encode(array('status' => 'error', 'message' => 'Method not allowed.'));
}
?>
