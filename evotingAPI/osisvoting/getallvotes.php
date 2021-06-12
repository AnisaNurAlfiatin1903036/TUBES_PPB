<?php
include 'db.php';

$sql = "SELECT COUNT(*) FROM votes";

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
