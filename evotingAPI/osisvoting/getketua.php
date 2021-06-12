<?php
include 'db.php';

$sql = "SELECT * FROM candidates WHERE position_id = '1'";

$result = array();

$query = $conn->query($sql);


while ($row = $query->fetch_assoc()) {
    $result[] = $row;
}
if ($query->num_rows > 0) {
    echo json_encode(['data' => $result]);
} else {
    echo json_encode(['error' => 'Kata Sandi Salah!!']);
}
