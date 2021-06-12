<?php
include 'db.php';

$voter = $_POST['voter'];

$sql = "SELECT * FROM votes WHERE voters_id = '$voter'";
$query = $conn->query($sql);

if ($query->num_rows > 0) {
    $row = $query->fetch_assoc();
    echo json_encode(['error' => 'Anda Telah Melakukan Vote']);
} else {
    echo json_encode(['nama' => 'Silahkan Melakukan Voting']);
}
